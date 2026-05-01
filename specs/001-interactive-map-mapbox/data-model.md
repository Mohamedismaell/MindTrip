# Data Model — Interactive Map with Mapbox

**Feature**: 001-interactive-map-mapbox  
**Date**: 2026-05-01

---

## Entity Overview

```
PlaceModel (existing, shared)
    └── LocationModel (existing, shared)
    └── categoryId → maps to PlaceCategory (new, map-feature constant)

MapAnnotationEntry (new, map-feature only)
    └── place: PlaceModel
    └── sequenceNumber: int
    └── annotationId: String? (set after Mapbox creates annotation)

SearchSuggestion (new, map-feature)
MapSearchResult (new, map-feature)

MapRoute (new, map-feature)

MapState (Cubit state, new)
```

---

## Existing Entities (unchanged)

### `PlaceModel` — `lib/core/shared/data/models/place_model.dart`

Already has all needed fields:

| Field | Type | Notes |
|---|---|---|
| `id` | `String` | Unique identifier |
| `name` | `String` | Display name |
| `description` | `String?` | Body text for bottom sheet |
| `thumbnailUrl` | `String` | Primary image for bottom sheet |
| `imageUrls` | `List<String>?` | Gallery (future) |
| `categoryId` | `String?` | Maps to `PlaceCategory` |
| `location.latitude` | `double` | Map coordinate |
| `location.longitude` | `double` | Map coordinate |
| `location.address` | `String` | Human-readable address |
| `rating` | `double?` | For bottom sheet |
| `price` | `double?` | For bottom sheet |

**No changes required** to `PlaceModel`.

---

## New Entities

### `PlaceCategory` — `lib/features/map/domain/entities/place_category.dart`

Enum mapping a `categoryId` string to a display icon asset path and label.

```dart
enum PlaceCategory {
  restaurant,
  landmark,
  hotel,
  beach,
  park,
  museum,
  shopping,
  entertainment,
  other;

  /// Maps PlaceModel.categoryId → PlaceCategory
  static PlaceCategory fromCategoryId(String? id) { ... }

  /// Returns the asset path for the category icon PNG (48x48 px)
  String get iconAssetPath { ... }

  /// Display label
  String get label { ... }
}
```

Category-to-asset mapping lives in `lib/features/map/domain/entities/place_category.dart` (domain constant — not in UI). All icon PNGs are at `assets/icons/map/<category>.png`.

---

### `MapAnnotationEntry` — `lib/features/map/domain/entities/map_annotation_entry.dart`

Lightweight wrapper binding a `PlaceModel` to its Mapbox annotation ID and sequence number. Lives only in memory (not persisted).

```dart
class MapAnnotationEntry extends Equatable {
  final PlaceModel place;
  final int sequenceNumber;       // 1-based display number on badge
  final String? mapboxAnnotationId; // filled after createPointAnnotation()
  ...
}
```

---

### `SearchSuggestion` — `lib/features/map/domain/entities/search_suggestion.dart`

Represents one autocomplete suggestion returned by Mapbox Search Box API `/suggest`.

```dart
class SearchSuggestion extends Equatable {
  final String mapboxId;       // used for /retrieve call
  final String name;           // display text (primary)
  final String? placeFormatted; // display text (secondary, e.g. "Cairo, Egypt")
  ...
}
```

---

### `MapSearchResult` — `lib/features/map/domain/entities/map_search_result.dart`

Full resolved result from Mapbox `/retrieve`. Contains coordinates for camera.

```dart
class MapSearchResult extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  ...
}
```

---

### `MapRoute` — `lib/features/map/domain/entities/map_route.dart`

Represents a route drawn on the map.

```dart
class MapRoute extends Equatable {
  final List<Position> waypoints; // ordered coordinate list
  final String geoJsonGeometry;  // raw GeoJSON LineString string from Directions API
  ...
}
```

---

## Cubit State

### `MapState` — `lib/features/map/presentation/cubit/map_state.dart`

```dart
class MapState extends Equatable {
  // ─── Markers ───────────────────────────────────────────────
  final List<MapAnnotationEntry> annotations;

  // ─── Selected place (bottom sheet) ─────────────────────────
  final PlaceModel? selectedPlace;
  final bool isBottomSheetVisible;

  // ─── Search ─────────────────────────────────────────────────
  final List<SearchSuggestion> searchSuggestions;
  final bool isSearchLoading;
  final String? searchError;

  // ─── Route ──────────────────────────────────────────────────
  final MapRoute? activeRoute;
  final bool isRouteLoading;
  final String? routeError;

  // ─── General ────────────────────────────────────────────────
  final bool isLocationGranted;
}
```

All fields are immutable; `copyWith` used for state transitions.

---

## Data Flow

```
UI (MapScreen)
  │
  ├── [places passed in] → MapCubit.loadPlaces(List<PlaceModel>)
  │       └── domain: MapAnnotationEntry created per place
  │       └── Presentation: draw PointAnnotations on map
  │
  ├── [marker tap] → MapCubit.selectPlace(placeId)
  │       └── state.selectedPlace updated
  │       └── UI: bottom sheet shows
  │
  ├── [search input] → MapCubit.search(query)
  │       └── MapSearchRepository.suggest(query)
  │       └── state.searchSuggestions updated
  │
  ├── [suggestion tapped] → MapCubit.resolveSearchResult(mapboxId)
  │       └── MapSearchRepository.retrieve(mapboxId)
  │       └── camera flies to result coords
  │
  ├── [navigate here] → MapCubit.navigateToPlace(place)
  │       └── MapRouteRepository.getRoute([userPos, place.coords])
  │       └── state.activeRoute set → route layer drawn on map
  │
  └── [navigate all] → MapCubit.navigateAll()
          └── MapRouteRepository.getRoute([userPos, ...all place coords])
          └── state.activeRoute set → route layer drawn
```

---

## Repository Interfaces (Domain)

### `MapSearchRepository` — `lib/features/map/domain/repositories/map_search_repository.dart`

```dart
abstract class MapSearchRepository {
  Future<Either<Failure, List<SearchSuggestion>>> suggest(String query, String sessionToken);
  Future<Either<Failure, MapSearchResult>> retrieve(String mapboxId, String sessionToken);
}
```

### `MapRouteRepository` — `lib/features/map/domain/repositories/map_route_repository.dart`

```dart
abstract class MapRouteRepository {
  Future<Either<Failure, MapRoute>> getRoute(List<Position> waypoints, String profile);
}
```

---

## Directory Layout (this feature)

```text
lib/features/map/
├── di/
│   └── map_di.dart                        (extend existing — add new registrations)
├── Services/
│   └── location_service/                  (existing — no changes)
├── data/
│   ├── datasources/
│   │   ├── map_search_remote_datasource.dart   (Dio → Search Box API)
│   │   └── map_route_remote_datasource.dart    (Dio → Directions API v5)
│   └── repositories/
│       ├── map_search_repository_impl.dart
│       └── map_route_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── place_category.dart
│   │   ├── map_annotation_entry.dart
│   │   ├── search_suggestion.dart
│   │   ├── map_search_result.dart
│   │   └── map_route.dart
│   └── repositories/
│       ├── map_search_repository.dart
│       └── map_route_repository.dart
└── presentation/
    ├── cubit/
    │   ├── map_cubit.dart
    │   └── map_state.dart
    ├── screens/
    │   └── map_screen.dart                (refactor existing)
    └── widgets/
        ├── map_search_bar.dart            (refactor existing — make functional)
        ├── place_info_bottom_sheet.dart   (refactor existing — accept PlaceModel)
        ├── map_relocate_button.dart       (new)
        └── map_navigation_bar.dart        (new — navigate here / navigate all)

assets/icons/map/
├── restaurant.png
├── landmark.png
├── hotel.png
├── beach.png
├── park.png
├── museum.png
├── shopping.png
├── entertainment.png
└── other.png
```
