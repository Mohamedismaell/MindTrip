# Quickstart: Interactive Map Feature

## Prerequisites

- Flutter SDK ^3.9.2
- A Mapbox access token (public key, `pk.*`)
- Android: `minSdkVersion 21`, `compileSdk 34`
- iOS: deployment target 14.0+

## Running the map screen

```bash
flutter run --dart-define ACCESS_TOKEN=pk.your_mapbox_token_here
```

The access token is read at compile time via:
```dart
const String.fromEnvironment('ACCESS_TOKEN')
```

## Passing places to the map

The refactored `MapScreen` accepts an optional `places` list:
```dart
MapScreen(places: [
  PlaceModel(
    id: '1',
    name: 'Egyptian Museum',
    location: LocationModel(
      address: 'Tahrir Square, Cairo',
      latitude: 30.0478,
      longitude: 31.2336,
    ),
    thumbnailUrl: 'https://...',
    categoryId: 'museum',
    ...
  ),
])
```

## Phase implementation order

1. **Phase 1** first — all domain/data/cubit code. Confirm tests pass.
2. **Phase 2** + **Phase 3** can be done in any order or simultaneously.
3. **Phase 4** last — depends on Phase 2 bottom sheet structure.

## Category icons

Place 9 PNG files (48×48, transparent background) at:
```
assets/icons/map/restaurant.png
assets/icons/map/landmark.png
assets/icons/map/hotel.png
assets/icons/map/beach.png
assets/icons/map/park.png
assets/icons/map/museum.png
assets/icons/map/shopping.png
assets/icons/map/entertainment.png
assets/icons/map/other.png
```

Then run `flutter pub get` to ensure the asset folder is registered.

## Mapbox Search Box API endpoints

```
Suggest: GET https://api.mapbox.com/search/searchbox/v1/suggest
  ?q=<text>
  &session_token=<uuid>
  &language=en
  &limit=5
  &access_token=<token>

Retrieve: GET https://api.mapbox.com/search/searchbox/v1/retrieve/<mapbox_id>
  ?session_token=<uuid>
  &access_token=<token>
```

## Mapbox Directions API endpoint

```
GET https://api.mapbox.com/directions/v5/mapbox/driving/<lng1,lat1;lng2,lat2>
  ?geometries=geojson
  &overview=full
  &access_token=<token>
```

Waypoints are semicolon-separated `longitude,latitude` pairs (up to 25).
