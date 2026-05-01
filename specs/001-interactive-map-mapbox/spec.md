# Feature Specification: Interactive Map with Multi-Location & Navigation

**Feature Branch**: `001-interactive-map-mapbox`
**Created**: 2026-05-01
**Status**: Draft
**Input**: User description: "in my app i want my map to be interactive able to take more than 1 location so it displays user dot and number of locations that will be passed into it with details like image description etc user should be able to click on any of those places and it will display the info in the bottom sheet also option for relocate user location button and navigation start from point to point or through all the points of places every place would have category so depend on the category it will appear icon related to this category mark also need to add search for location all that using mapBox last versions so search for it"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Places on Map (Priority: P1)

A user opens the Map screen and immediately sees all provided places (up to N locations) plotted as interactive map markers. Each marker displays a category-specific icon (e.g., a fork-and-knife icon for restaurants, a camera icon for landmarks) and a numbered badge showing its sequence order. The user's own real-time position is displayed as a pulsing dot.

**Why this priority**: This is the core functionality — without visible place markers and user location, the map has no value.

**Independent Test**: Open the Map screen while passing a list of places. Confirm markers appear at correct coordinates with the right category icon and sequential numbers. Confirm user dot is visible.

**Acceptance Scenarios**:

1. **Given** the Map screen receives a list of 5 places, **When** the map finishes loading, **Then** 5 markers appear at their respective coordinates, each with a numbered badge (1–5) and a category icon matching each place's category.
2. **Given** the device has location permission granted, **When** the map loads, **Then** a pulsing user location dot is visible at the device's current position.
3. **Given** no places are passed, **When** the map loads, **Then** only the user dot is shown and no markers appear.

---

### User Story 2 - Tap a Place to View Details (Priority: P1)

A user taps any marker on the map. The camera smoothly animates to center on that marker, and a bottom sheet slides up from the bottom of the screen showing the selected place's image, name, description, category label, and any other relevant details. The sheet is draggable (collapse/expand).

**Why this priority**: Tapping and learning about a location is the primary interactive use case for the map.

**Independent Test**: Tap any marker. Verify the bottom sheet appears with correct image, name, description, and category for the tapped place.

**Acceptance Scenarios**:

1. **Given** markers are displayed, **When** the user taps a marker, **Then** the bottom sheet slides up displaying the place's image, name, description, and category.
2. **Given** the bottom sheet is open, **When** the user swipes it down, **Then** it collapses to its minimum peek state.
3. **Given** the bottom sheet is in its peek state, **When** the user swipes it up, **Then** it expands to show full place details.
4. **Given** the bottom sheet is open, **When** the user taps the map outside the sheet, **Then** the sheet collapses/dismisses.

---

### User Story 3 - Search for a Location (Priority: P2)

A user taps the search bar at the top of the map. A search input becomes active and the user can type a place name or address. Results appear as the user types (autocomplete suggestions from Mapbox Search/Geocoding API). Selecting a result moves the camera to that location.

**Why this priority**: Discovery via search is key for users who know where they want to go.

**Independent Test**: Activate the search bar, type "Cairo", and confirm autocomplete suggestions appear. Select a result and confirm the camera flies to that location.

**Acceptance Scenarios**:

1. **Given** the map is displayed, **When** the user taps the search bar, **Then** the search input becomes active and a keyboard appears.
2. **Given** the user has typed at least 3 characters, **When** results are available, **Then** a list of autocomplete location suggestions is displayed below the search bar.
3. **Given** suggestions are shown, **When** the user taps a suggestion, **Then** the map camera animates to that location and the search bar shows the selected place name.
4. **Given** no results are found, **When** search is complete, **Then** an appropriate "No results" message is shown.

---

### User Story 4 - Relocate to User Position (Priority: P2)

A visible floating button (e.g., a crosshair/GPS icon) is always available on the map. When tapped, the camera smoothly flies back to the user's current location regardless of where the user has panned the map.

**Why this priority**: After exploring the map, users need a quick way to re-center on themselves.

**Independent Test**: Pan the map away from the user's location. Tap the relocate button. Confirm the camera animates back to the user's position.

**Acceptance Scenarios**:

1. **Given** the user has panned the map away from their position, **When** the relocate button is tapped, **Then** the camera animates (flyTo) back to the user's current GPS position.
2. **Given** location permission is not granted, **When** the relocate button is tapped, **Then** the user is shown a permission request or an informative message.

---

### User Story 5 - Navigate Through Places (Priority: P3)

A user can start a navigation session from their current location through one or all of the map's place markers. Navigation options include:
- **Point-to-point**: Navigate from the user's position to a single selected place.
- **Full route**: Navigate through all places in sequence (ordered by their displayed number).

The app launches navigation using the device's native maps or Mapbox Navigation, displaying a route polyline on the map.

**Why this priority**: Navigation is an enhancement that adds significant value once places and search are functional.

**Independent Test**: Tap "Navigate" from the bottom sheet of a selected place. Confirm a route polyline appears on the map from the user's position to that place. Also test the "Navigate through all" option.

**Acceptance Scenarios**:

1. **Given** a place's bottom sheet is open, **When** the user taps "Navigate Here", **Then** a route polyline is drawn on the map from the user's current position to that place.
2. **Given** multiple places are displayed, **When** the user triggers "Navigate through all", **Then** a route connecting all places in order (by number) is drawn on the map.
3. **Given** a route is active, **When** the user taps a "Stop Navigation" control, **Then** the route polyline is removed from the map.

---

### Edge Cases

- What happens when the app cannot determine the user's location (e.g., GPS off or permission denied)?
  → Show a non-blocking warning and disable location-dependent features gracefully.
- What happens if a place has no image or incomplete details?
  → The bottom sheet shows a placeholder image and available fields only.
- What happens when too many places are passed (e.g., 100+)?
  → Markers are rendered using clustering or style layers for performance (assumed: up to ~50 for initial version, documented as assumption).
- What happens if the search API is unreachable?
  → The search bar shows a "Search unavailable" error state.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The map MUST accept a list of place objects (with coordinates, name, image URL, description, and category) and render a marker for each.
- **FR-002**: Each marker MUST display a category-specific icon determined by the place's category value.
- **FR-003**: Each marker MUST display a numbered badge (sequential order, 1-based) visible on the map.
- **FR-004**: The user's real-time location MUST be displayed as a pulsing dot on the map.
- **FR-005**: Tapping a marker MUST open a bottom sheet displaying the place's image, name, description, and category.
- **FR-006**: The bottom sheet MUST be draggable (collapsible and expandable).
- **FR-007**: The map MUST include a search bar that accepts text input and returns Mapbox-powered autocomplete location suggestions.
- **FR-008**: Selecting a search suggestion MUST animate the map camera to the selected location.
- **FR-009**: A "relocate" (re-center on user) floating button MUST be present and functional.
- **FR-010**: The map MUST support point-to-point navigation from the user's location to a selected place, drawing a route polyline.
- **FR-011**: The map MUST support full-route navigation through all provided places in numbered sequence.
- **FR-012**: Each place category MUST map to a distinct icon; the mapping MUST be defined in a central constant/config, not hardcoded in UI widgets.

### Key Entities

- **MapPlace**: A location to display on the map. Attributes: id, name, description, imageUrl, latitude, longitude, category (enum/string), sequenceNumber.
- **PlaceCategory**: An enum or sealed class defining all supported categories (e.g., Restaurant, Landmark, Hotel, Beach, Park, Museum, etc.) with an associated icon.
- **MapRoute**: Represents an active navigation route. Attributes: waypoints (ordered list of coordinates), routePolyline (GeoJSON LineString).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All provided place markers appear on the map within 2 seconds of the map finishing its initial load.
- **SC-002**: Tapping a marker opens the bottom sheet with correct place data in under 300 milliseconds.
- **SC-003**: Search autocomplete suggestions appear within 1 second of the user stopping typing.
- **SC-004**: Relocate button returns the camera to the user's position within 1.5 seconds (matching existing flyTo animation duration).
- **SC-005**: Category icons are visually distinct and recognizable for all defined categories.
- **SC-006**: Navigation route polyline renders within 3 seconds of the user requesting navigation.

---

## Assumptions

- The map will be used primarily on Android and iOS (web/desktop not required, consistent with Mapbox Flutter SDK limitations).
- The list of places is passed into the map widget/screen via its constructor or Cubit state (not fetched by the map itself from a remote API — caller is responsible).
- Place categories are a predefined, finite set (not dynamic from a server). The initial set will be defined during planning.
- For the initial version, the number of simultaneous places is assumed to be ≤ 50; performance optimizations (clustering) are considered a future enhancement if needed beyond this.
- Navigation uses Mapbox's route drawing capability (drawing a polyline via GeoJSON on the map); full turn-by-turn navigation via Mapbox Navigation SDK is a future enhancement.
- The Mapbox access token is already configured in the project via `--dart-define` (existing pattern in codebase).
- The search feature uses the Mapbox Search Box API or Geocoding API v6 (latest), consistent with mapbox_maps_flutter v2.23.0.
- The existing `mapbox_maps_flutter` package (already installed) will be used; no additional navigation-specific package is required for v1.
