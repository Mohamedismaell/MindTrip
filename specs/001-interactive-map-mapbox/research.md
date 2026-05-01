# Phase 0 Research — Interactive Map with Mapbox

**Feature**: 001-interactive-map-mapbox  
**Date**: 2026-05-01  
**Status**: Complete — all NEEDS CLARIFICATION items resolved

---

## R-001: Marker click listeners (`PointAnnotationManager`)

**Decision**: Use `PointAnnotationManager.addOnPointAnnotationClickListener`.  
**Rationale**: This is the standard, officially-documented API in `mapbox_maps_flutter` 2.22. The listener receives the tapped `PointAnnotation` object, from which we read a custom-property stored at annotation creation time (the place `id`).  
**API pattern**:
```dart
final mgr = await mapboxMap.annotations.createPointAnnotationManager();
mgr.addOnPointAnnotationClickListener(
  OnPointAnnotationClickListener((annotation) {
    // annotation.textField or custom property holds place id
    return true; // consume event
  }),
);
```
**Known gotcha**: Calling `.update()` on an annotation may break subsequent click events in some SDK versions. Workaround: delete + recreate the annotation instead of updating.  
**Alternatives rejected**: `TapInteraction` on style layers — more complex, needed only for 50+ markers with clustering (future).

---

## R-002: Custom icon per marker category

**Decision**: Render icon as a Flutter `Canvas`-drawn image (or pre-loaded `Uint8List` PNG) set via `PointAnnotationOptions.image`.  
**Rationale**: `PointAnnotationManager` accepts `image: Uint8List` (raw PNG bytes). We generate category badge images at runtime using `ui.PictureRecorder` + `Canvas`, or load pre-bundled SVG/PNG assets via `rootBundle`. The latter (static PNG assets per category) is simplest and most reliable.  
**Pattern**: Load asset → `rootBundle.load(path)` → `ByteData` → `.buffer.asUint8List()` → pass to `PointAnnotationOptions.image`.  
**Badge number overlay**: Draw category icon + number badge together as a single composited image using Flutter's `Canvas` API before passing to Mapbox.

---

## R-003: Location display

**Decision**: Use `mapboxMap.location.updateSettings(LocationComponentSettings(enabled: true, pulsingEnabled: true, ...))`.  
**Rationale**: Already implemented in the existing `MapScreen._onMapCreated`. No new code needed — this carries over as-is.

---

## R-004: Search autocomplete

**Decision**: Use **Mapbox Search Box REST API** directly over `Dio` (already a project dependency).  
**Flow**:
1. `POST /suggest?q=<text>&session_token=<uuid>&access_token=<token>` → returns suggestion list.
2. User selects → `GET /retrieve/<mapbox_id>?session_token=<uuid>&access_token=<token>` → returns coordinates.
3. Camera flies to coordinates.

**Rationale**: No additional Flutter package required (avoids `mapbox_search` package). `Dio` is already in the project. This keeps XI (minimal dependencies) satisfied.  
**Base URL**: `https://api.mapbox.com/search/searchbox/v1`  
**Alternatives rejected**: `mapbox_search` pub.dev package — adds a dependency for something we can implement with existing `Dio`.

---

## R-005: Route polyline drawing

**Decision**: Use **Mapbox Directions REST API v5** over `Dio` + draw result using `mapboxMap.style.addSource/addLayer` (GeoJSON LineString).  
**Flow**:
1. Call `GET https://api.mapbox.com/directions/v5/mapbox/driving/<lng1,lat1;lng2,lat2...>?geometries=geojson&overview=full&access_token=<token>`.
2. Response contains `routes[0].geometry` as a GeoJSON `LineString`.
3. Add `GeoJsonSource(id: 'route_source', data: geometry_json)` to the map style.
4. Add `LineLayer(id: 'route_layer', sourceId: 'route_source', lineColor: ..., lineWidth: 5)`.
5. To remove: `mapboxMap.style.removeStyleLayer('route_layer')` + `removeStyleSource('route_source')`.

**Waypoints**: Supports up to 25 waypoints per request — sufficient for ≤50 places (split into batches if needed, future concern).  
**Rationale**: `Dio` already in project. No extra SDK package. `geometries=geojson` eliminates need for a polyline decoder library (satisfies XI: minimal dependencies).

---

## R-006: DI & Cubit wiring

**Decision**: Add a `MapCubit` to the existing `map` feature's `di/map_di.dart`.  
**Rationale**: Existing `MapDi` only registers `LocationService` and `LocationCubit`. We extend it to register `MapSearchRepository`, `MapRouteRepository`, `MapCubit`.  
**No new DI framework needed** — `get_it` is already the service locator.

---

## R-007: Avoiding new packages

The following were evaluated and **rejected** to preserve XI (minimal dependencies):

| Package | Why rejected |
|---|---|
| `mapbox_search` | Replaced by direct Dio calls |
| `google_polyline_algorithm` | Not needed — using `geometries=geojson` |
| `flutter_polyline_points` | Same reason |
| `uuid` | `DateTime.now().millisecondsSinceEpoch.toString()` sufficient for session tokens |

**Only existing packages used**: `dio`, `mapbox_maps_flutter`, `flutter_bloc`, `get_it`, `equatable`.
