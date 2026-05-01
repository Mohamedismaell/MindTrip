# Implementation Plan: Interactive Map with Multi-Location & Navigation

**Branch**: `001-interactive-map-mapbox` | **Date**: 2026-05-01  
**Spec**: [spec.md](./spec.md) | **Research**: [research.md](./research.md) | **Data Model**: [data-model.md](./data-model.md)

> **User input**: "plan for cheaper model to implement without problems, divide into phases"  
> This plan is split into 4 self-contained phases. Each phase compiles, runs, and delivers user-visible value independently. A junior model can implement one phase at a time without needing context from future phases.

---

## Summary

Enhance the existing `MapScreen` to become a fully interactive map powered by `mapbox_maps_flutter` 2.22.  
Callers pass a `List<PlaceModel>` into the screen. The map renders a numbered category-icon marker for each place. Tapping a marker opens a rich bottom sheet. A search bar queries the Mapbox Search Box API. A relocate button re-centers on the user. A navigation flow calls the Mapbox Directions API and draws a route polyline on the map.

No new Flutter packages are required. All network calls use the existing `Dio` instance. State is managed by a new `MapCubit`.

---

## Technical Context

**Language/Version**: Dart (Flutter SDK ^3.9.2)  
**Primary Dependencies**: `mapbox_maps_flutter ^2.22.0`, `flutter_bloc ^9.1.1`, `dio ^5.9.0`, `get_it ^9.0.5`, `equatable ^2.0.8`  
**Storage**: None (in-memory only; no Hive for this feature)  
**Testing**: `flutter_test` (unit tests for Cubits, Repository impls, entity mappers)  
**Target Platform**: Android + iOS  
**Project Type**: Mobile app — Flutter  
**Performance Goals**: Markers visible <2s after map load; bottom sheet open <300ms; search suggestions <1s  
**Constraints**: No new packages; access token via `--dart-define ACCESS_TOKEN=...` (existing pattern)  
**Scale/Scope**: ≤50 markers per map session

---

## Constitution Check

*GATE: Must pass before implementation. All items confirmed ✅*

- [x] **Clean Architecture**: `MapCubit` (Presentation) → `MapSearchRepository` / `MapRouteRepository` interfaces (Domain) → `*RepositoryImpl` (Data). No UI → Data shortcuts.
- [x] **State Management**: Single `MapCubit` with immutable `MapState`. `context.select` used in UI for granular rebuilds.
- [x] **Data Handling**: `MapSearchRemoteDatasource` + `MapRouteRemoteDatasource` → Repositories → Cubit. Dio in datasource only.
- [x] **Error Handling**: All repository methods return `Either<Failure, T>`. No silent failures.
- [x] **Testing**: Unit tests planned for `MapCubit`, `MapSearchRepositoryImpl`, `MapRouteRepositoryImpl`.
- [x] **Feature Development**: Feature is self-contained under `lib/features/map/`. Domain entities, repositories, use-cases, and presentation are separate layers.

---

## Project Structure

```text
lib/features/map/
├── di/
│   └── map_di.dart                         ← extend existing
├── Services/location_service/              ← existing, unchanged
├── data/
│   ├── datasources/
│   │   ├── map_search_remote_datasource.dart
│   │   └── map_route_remote_datasource.dart
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
    │   └── map_screen.dart                 ← refactor
    └── widgets/
        ├── map_search_bar.dart             ← refactor
        ├── place_info_bottom_sheet.dart    ← refactor
        ├── map_relocate_button.dart        ← new
        └── map_navigation_bar.dart         ← new

assets/icons/map/
└── <category>.png  (9 files, one per PlaceCategory)

test/features/map/
├── cubit/map_cubit_test.dart
├── data/map_search_repository_test.dart
└── data/map_route_repository_test.dart
```

---

## Complexity Tracking

No constitution violations. No entries needed.

---

---

# PHASE 1 — Foundation: Domain, Data Layer & Cubit State

> **Goal**: All business logic exists and is testable. No UI changes yet. The map screen continues to work exactly as before.  
> **Deliverable**: Domain entities, repository interfaces, datasource implementations, `MapCubit` with `MapState`, DI wiring, unit tests.

### P1-T1 — Domain entities

Create the following pure Dart files (no Flutter imports, no Mapbox imports):

1. **`lib/features/map/domain/entities/place_category.dart`**
   - `enum PlaceCategory { restaurant, landmark, hotel, beach, park, museum, shopping, entertainment, other }`
   - Extension: `PlaceCategory.fromCategoryId(String? id)` — maps known string IDs to enum values, defaults to `other`.
   - Extension: `String get iconAssetPath` — returns `'assets/icons/map/<name>.png'`.
   - Extension: `String get label` — returns human-readable label.

2. **`lib/features/map/domain/entities/map_annotation_entry.dart`**
   - Fields: `place: PlaceModel`, `sequenceNumber: int`, `mapboxAnnotationId: String?`
   - `Equatable` with `copyWith`

3. **`lib/features/map/domain/entities/search_suggestion.dart`**
   - Fields: `mapboxId: String`, `name: String`, `placeFormatted: String?`
   - `Equatable`

4. **`lib/features/map/domain/entities/map_search_result.dart`**
   - Fields: `name: String`, `latitude: double`, `longitude: double`, `address: String?`
   - `Equatable`

5. **`lib/features/map/domain/entities/map_route.dart`**
   - Fields: `waypoints: List<Position>` (mapbox Position), `geoJsonGeometry: String`
   - `Equatable`

### P1-T2 — Repository interfaces

1. **`lib/features/map/domain/repositories/map_search_repository.dart`**
   ```dart
   abstract class MapSearchRepository {
     Future<Either<Failure, List<SearchSuggestion>>> suggest(String query, String sessionToken);
     Future<Either<Failure, MapSearchResult>> retrieve(String mapboxId, String sessionToken);
   }
   ```

2. **`lib/features/map/domain/repositories/map_route_repository.dart`**
   ```dart
   abstract class MapRouteRepository {
     Future<Either<Failure, MapRoute>> getRoute(List<Position> waypoints, {String profile = 'driving'});
   }
   ```

> Use the project's existing `Failure` class from `lib/core/`.

### P1-T3 — Remote datasources

1. **`lib/features/map/data/datasources/map_search_remote_datasource.dart`**
   - Depends on `Dio` instance (injected).
   - `suggest(query, sessionToken)`:  
     `GET https://api.mapbox.com/search/searchbox/v1/suggest?q=<query>&session_token=<token>&access_token=<token>`  
     Parse JSON → `List<SearchSuggestion>`.
   - `retrieve(mapboxId, sessionToken)`:  
     `GET https://api.mapbox.com/search/searchbox/v1/retrieve/<id>?session_token=<token>&access_token=<token>`  
     Parse JSON → `MapSearchResult`.
   - Throws `DioException` on network errors; caught by repository.

2. **`lib/features/map/data/datasources/map_route_remote_datasource.dart`**
   - Depends on `Dio`.
   - `getRoute(waypoints, profile)`:  
     `GET https://api.mapbox.com/directions/v5/mapbox/<profile>/<coords>?geometries=geojson&overview=full&access_token=<token>`  
     `<coords>` = `waypoints.map((p) => '${p.lng},${p.lat}').join(';')`  
     Parse `routes[0].geometry` → `MapRoute`.

> Access token: `const String.fromEnvironment('ACCESS_TOKEN')` — consistent with existing pattern in codebase.

### P1-T4 — Repository implementations

1. **`lib/features/map/data/repositories/map_search_repository_impl.dart`**
   - Wraps datasource calls in `try/catch`, returns `Either<Failure, T>`.

2. **`lib/features/map/data/repositories/map_route_repository_impl.dart`**
   - Same pattern.

### P1-T5 — MapCubit & MapState

1. **`lib/features/map/presentation/cubit/map_state.dart`**
   ```dart
   class MapState extends Equatable {
     final List<MapAnnotationEntry> annotations;
     final PlaceModel? selectedPlace;
     final bool isBottomSheetVisible;
     final List<SearchSuggestion> searchSuggestions;
     final bool isSearchLoading;
     final String? searchError;
     final MapRoute? activeRoute;
     final bool isRouteLoading;
     final String? routeError;
     final bool isLocationGranted;
     const MapState({...});
     MapState copyWith({...});
     static MapState initial() => const MapState(annotations: [], ...);
   }
   ```

2. **`lib/features/map/presentation/cubit/map_cubit.dart`**
   - Methods:
     - `loadPlaces(List<PlaceModel> places)` — creates `MapAnnotationEntry` list (sequenceNumber = index+1).
     - `selectPlace(String placeId)` — finds place by id, emits `selectedPlace` + `isBottomSheetVisible: true`.
     - `dismissBottomSheet()` — emits `isBottomSheetVisible: false`, clears `selectedPlace`.
     - `search(String query)` — debounced (300ms), calls `MapSearchRepository.suggest`, emits suggestions.
     - `clearSearch()` — clears suggestions.
     - `resolveSearchResult(String mapboxId, String sessionToken)` — calls `retrieve`, emits result.
     - `navigateToPlace(PlaceModel place, Position userPosition)` — calls route repo, emits `activeRoute`.
     - `navigateAll(Position userPosition)` — calls route repo with all annotation coords, emits `activeRoute`.
     - `stopNavigation()` — clears `activeRoute`.
     - `setLocationGranted(bool granted)`.
   - All async methods handle errors via `Either.fold`, emit error state on `Left`.

### P1-T6 — DI wiring

Extend **`lib/features/map/di/map_di.dart`**:
```dart
// New registrations:
sl.registerLazySingleton<MapSearchRemoteDatasource>(
  () => MapSearchRemoteDatasourceImpl(dio: sl<Dio>()),
);
sl.registerLazySingleton<MapRouteRemoteDatasource>(
  () => MapRouteRemoteDatasourceImpl(dio: sl<Dio>()),
);
sl.registerLazySingleton<MapSearchRepository>(
  () => MapSearchRepositoryImpl(datasource: sl()),
);
sl.registerLazySingleton<MapRouteRepository>(
  () => MapRouteRepositoryImpl(datasource: sl()),
);
sl.registerFactory<MapCubit>(
  () => MapCubit(
    searchRepo: sl(),
    routeRepo: sl(),
  ),
);
```

### P1-T7 — Unit tests

File: `test/features/map/cubit/map_cubit_test.dart`
- Test `loadPlaces` → correct `annotations` with sequenceNumbers.
- Test `selectPlace` → correct `selectedPlace` and `isBottomSheetVisible: true`.
- Test `dismissBottomSheet` → clears state.
- Test `search` with mock repo → `isSearchLoading` transitions + suggestions populated.
- Test `navigateToPlace` with mock repo → `activeRoute` populated.

File: `test/features/map/data/map_search_repository_test.dart`
- Mock datasource; test `Right` and `Left` paths.

File: `test/features/map/data/map_route_repository_test.dart`
- Same pattern.

---

# PHASE 2 — Markers & Bottom Sheet

> **Goal**: Markers appear on the map with category icons + numbered badges. Tapping opens the bottom sheet with real `PlaceModel` data.  
> **Depends on**: Phase 1 complete.  
> **Deliverable**: Updated `MapScreen` + `PlaceInfoBottomSheet`. User can see and tap places.

### P2-T1 — Category icon assets

Create/source 9 PNG files (48×48 px, transparent background):
- `assets/icons/map/restaurant.png`
- `assets/icons/map/landmark.png`
- `assets/icons/map/hotel.png`
- `assets/icons/map/beach.png`
- `assets/icons/map/park.png`
- `assets/icons/map/museum.png`
- `assets/icons/map/shopping.png`
- `assets/icons/map/entertainment.png`
- `assets/icons/map/other.png`

Register the folder in `pubspec.yaml`:
```yaml
assets:
  - assets/icons/map/   # add this line
```

### P2-T2 — Marker image compositor

Create **`lib/features/map/presentation/widgets/map_marker_painter.dart`**:

```dart
/// Composites a category PNG with a white numbered badge overlay.
/// Returns Uint8List (raw PNG) suitable for PointAnnotationOptions.image.
Future<Uint8List> buildMarkerImage({
  required String assetPath,
  required int sequenceNumber,
}) async { ... }
```

Implementation:
1. Load asset PNG → `ui.Image`.
2. Create `ui.PictureRecorder` canvas at 56×64 px.
3. Draw category icon (48×48) centered horizontally.
4. Draw circle badge (16×16, white fill + brand colour stroke) at top-right.
5. Draw sequence number text inside badge.
6. Export as PNG `Uint8List`.

### P2-T3 — MapScreen refactor (markers)

Refactor **`lib/features/map/presentation/screens/map_screen.dart`**:

- Accept `List<PlaceModel> places` in constructor (nullable/optional; defaults to `[]`).
- Provide `MapCubit` via `BlocProvider(create: (_) => sl<MapCubit>()..loadPlaces(places))`.
- Store `PointAnnotationManager` as a field.
- After `_onMapCreated`, call `_drawAnnotations()`:
  ```dart
  Future<void> _drawAnnotations() async {
    final annotations = context.read<MapCubit>().state.annotations;
    for (final entry in annotations) {
      final img = await buildMarkerImage(
        assetPath: PlaceCategory.fromCategoryId(entry.place.categoryId).iconAssetPath,
        sequenceNumber: entry.sequenceNumber,
      );
      final annotation = await pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(
            entry.place.location.longitude,
            entry.place.location.latitude,
          )),
          image: img,
          iconSize: 1.0,
        ),
      );
      // Store annotationId back via cubit or local map<id, placeId>
    }
    pointAnnotationManager!.addOnPointAnnotationClickListener(
      OnPointAnnotationClickListener((annotation) {
        final placeId = _annotationIdToPlaceId[annotation.id];
        if (placeId != null) context.read<MapCubit>().selectPlace(placeId);
        return true;
      }),
    );
  }
  ```
- Keep a `Map<String, String> _annotationIdToPlaceId` local field (Mapbox annotation ID → place ID).

### P2-T4 — PlaceInfoBottomSheet refactor

Refactor **`lib/features/map/presentation/widgets/place_info_bottom_sheet.dart`**:

- Remove `placeName` constructor param.
- Use `context.select<MapCubit, (PlaceModel?, bool)>((c) => (c.state.selectedPlace, c.state.isBottomSheetVisible))`.
- When `isBottomSheetVisible = false`: `initialChildSize: 0.0` (fully hidden).
- When `isBottomSheetVisible = true`: animate to `initialChildSize: 0.45`.
- Content sections:
  1. Drag handle (keep existing).
  2. Hero image: `CachedNetworkImage` from `place.thumbnailUrl` (with placeholder).
  3. Name (`titleLarge`, bold).
  4. Category chip (using `PlaceCategory.fromCategoryId(place.categoryId).label`).
  5. Rating row (stars + count, if `place.rating != null`).
  6. Description text (`bodyMedium`, up to 5 lines, expandable).
  7. Address row (`bodySmall`, `place.location.address`).
  8. Navigation action bar (P4 — placeholder "Navigate" button for now).
- On dismiss (drag down): `context.read<MapCubit>().dismissBottomSheet()`.

---

# PHASE 3 — Search & Relocate

> **Goal**: The search bar is functional (autocomplete + camera move). The relocate button re-centers the camera.  
> **Depends on**: Phase 1 complete. Phase 2 not required (can run in parallel).  
> **Deliverable**: Working search + relocate. User can find and jump to any location.

### P3-T1 — Search screen / overlay

Create **`lib/features/map/presentation/screens/map_search_overlay.dart`**:

Full-screen overlay shown when the search bar is tapped:
- `TextField` (auto-focused, `TextInputAction.search`).
- `ListView` of `SearchSuggestion` items below the text field.
- Each item: primary text (name) + secondary text (placeFormatted).
- Calls `context.read<MapCubit>().search(query)` on text change (300ms debounce inside Cubit).
- Tapping a suggestion: `context.read<MapCubit>().resolveSearchResult(mapboxId, sessionToken)` → pop overlay → camera flies to result coords.
- Loading indicator while `isSearchLoading`.
- Error message when `searchError != null`.

### P3-T2 — MapSearchBar refactor

Refactor **`lib/features/map/widgets/map_search_bar.dart`**:
- Replace `//Todo enable search` with `GestureDetector(onTap: () => Navigator.push(...MapSearchOverlay...))`.
- Search bar remains a display-only pill; tapping opens the overlay.
- When a search result resolves (listen to `MapCubit` state change), pop overlay and call `mapboxMap.flyTo(...)` with result coordinates.

> **Camera access**: The `MapScreen` exposes a `flyToCoordinates(lat, lng)` method via a controller or callback. `MapSearchOverlay` receives this callback so it can move the camera after closing.

### P3-T3 — Relocate button

Create **`lib/features/map/presentation/widgets/map_relocate_button.dart`**:

```dart
class MapRelocateButton extends StatelessWidget {
  final VoidCallback onTap;
  const MapRelocateButton({required this.onTap, super.key});
  ...
}
```

- Floating circular button, bottom-right, above bottom sheet.
- Icon: `Icons.my_location_rounded`.
- On tap: calls `onTap` callback → `MapScreen._relocate()`:
  ```dart
  Future<void> _relocate() async {
    final pos = await sl<LocationService>().getCurrentLocation();
    if (pos == null || mapboxMap == null) return;
    mapboxMap!.flyTo(CameraOptions(
      center: Point(coordinates: Position(pos.longitude, pos.latitude)),
      zoom: 15,
    ), MapAnimationOptions(duration: 1200));
  }
  ```

### P3-T4 — MapScreen integration

Update `MapScreen` to:
- Place `MapRelocateButton` in the `Stack`, positioned bottom-right above the bottom sheet.
- Pass `onTap: _relocate` to `MapRelocateButton`.
- Add result-resolved listener on `MapCubit` to fly camera when search resolves.

---

# PHASE 4 — Navigation (Route Drawing)

> **Goal**: "Navigate Here" and "Navigate through all" draw a route polyline on the map.  
> **Depends on**: Phase 1 (route repo), Phase 2 (bottom sheet infrastructure).  
> **Deliverable**: Full navigation flow. User can see a route from their location to selected places.

### P4-T1 — Navigation action bar widget

Create **`lib/features/map/presentation/widgets/map_navigation_bar.dart`**:

```dart
class MapNavigationBar extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onNavigateHere;
  final VoidCallback? onNavigateAll;  // null if only 1 place on map
  final VoidCallback? onStopNavigation; // null if no active route
  ...
}
```

Layout: horizontal row at the bottom of the bottom sheet:
- `FilledButton` "Navigate Here" → `onNavigateHere`.
- `OutlinedButton` "All stops" → `onNavigateAll` (hidden if only 1 place).
- `TextButton` "Stop" (red) → `onStopNavigation` (visible only when route is active).

### P4-T2 — MapScreen navigation integration

Add to `MapScreen`:

```dart
Future<void> _navigateToPlace(PlaceModel place) async {
  final pos = await sl<LocationService>().getCurrentLocation();
  if (pos == null || !mounted) return;
  final userPosition = Position(pos.longitude, pos.latitude);
  final placePosition = Position(
    place.location.longitude, place.location.latitude,
  );
  context.read<MapCubit>().navigateToPlace(place, userPosition);
}

Future<void> _navigateAll() async {
  final pos = await sl<LocationService>().getCurrentLocation();
  if (pos == null || !mounted) return;
  context.read<MapCubit>().navigateAll(Position(pos.longitude, pos.latitude));
}
```

### P4-T3 — Route rendering on map

In `MapScreen`, listen to `MapCubit` state changes for `activeRoute`:
```dart
BlocListener<MapCubit, MapState>(
  listenWhen: (prev, curr) => prev.activeRoute != curr.activeRoute,
  listener: (context, state) {
    if (state.activeRoute != null) {
      _drawRoute(state.activeRoute!);
    } else {
      _clearRoute();
    }
  },
)
```

```dart
Future<void> _drawRoute(MapRoute route) async {
  // Remove old layers if they exist
  await _clearRoute();

  await mapboxMap!.style.addSource(GeoJsonSource(
    id: 'route_source',
    data: route.geoJsonGeometry,
  ));
  await mapboxMap!.style.addLayer(LineLayer(
    id: 'route_layer',
    sourceId: 'route_source',
    lineJoin: LineJoin.ROUND,
    lineCap: LineCap.ROUND,
    lineColor: 0xFF4264FB, // brand blue
    lineWidth: 5.0,
    lineOpacity: 0.85,
  ));
}

Future<void> _clearRoute() async {
  try {
    await mapboxMap!.style.removeStyleLayer('route_layer');
    await mapboxMap!.style.removeStyleSource('route_source');
  } catch (_) {} // ignore if not present
}
```

### P4-T4 — Camera zoom-to-fit route

After drawing the route, fit the camera to show all waypoints:
```dart
final coords = route.waypoints;
final bounds = CoordinateBounds(
  southwest: Point(coordinates: Position(
    coords.map((p) => p.lng.toDouble()).reduce(min),
    coords.map((p) => p.lat.toDouble()).reduce(min),
  )),
  northeast: Point(coordinates: Position(
    coords.map((p) => p.lng.toDouble()).reduce(max),
    coords.map((p) => p.lat.toDouble()).reduce(max),
  )),
  infiniteBounds: false,
);
await mapboxMap!.cameraForCoordinateBounds(
  bounds,
  MbxEdgeInsets(top: 80, left: 40, bottom: 300, right: 40),
  null, null, null, null,
).then((camera) => mapboxMap!.flyTo(camera, MapAnimationOptions(duration: 1200)));
```

### P4-T5 — Wire navigation bar into bottom sheet

In `PlaceInfoBottomSheet`, replace the "placeholder" navigation area with:
```dart
MapNavigationBar(
  place: selectedPlace,
  onNavigateHere: () => mapNavigateCallback(selectedPlace),
  onNavigateAll: annotations.length > 1 ? mapNavigateAllCallback : null,
  onStopNavigation: hasActiveRoute ? stopNavigationCallback : null,
)
```

> Use callbacks passed down from `MapScreen` to keep navigation logic in the screen and widgets pure.

---

## Phase Summary

| Phase | Deliverable | Key files created/changed | Tests |
|---|---|---|---|
| **1** | Domain + Data + Cubit | 10 new files, `map_di.dart` extended | 3 test files |
| **2** | Markers + Bottom Sheet | `map_screen.dart`, `place_info_bottom_sheet.dart`, `map_marker_painter.dart`, 9 icon PNGs | — |
| **3** | Search + Relocate | `map_search_overlay.dart`, `map_search_bar.dart`, `map_relocate_button.dart` | — |
| **4** | Navigation (route polyline) | `map_navigation_bar.dart`, route rendering in `map_screen.dart` | — |

Each phase can be implemented and committed independently. Phase 2 and 3 can be worked on simultaneously since they only depend on Phase 1.

---

## Quickstart for Implementer

See [quickstart.md](./quickstart.md) for step-by-step setup, token configuration, and how to run the map screen in isolation.
