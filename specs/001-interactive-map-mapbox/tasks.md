# Implementation Tasks: Interactive Map with Multi-Location & Navigation

## Phase 1: Foundation: Domain, Data Layer & Cubit State

- [] T001 [P] Create PlaceCategory entity in `lib/features/map/domain/entities/place_category.dart`
- [] T002 [P] Create MapAnnotationEntry entity in `lib/features/map/domain/entities/map_annotation_entry.dart`
- [] T003 [P] Create SearchSuggestion entity in `lib/features/map/domain/entities/search_suggestion.dart`
- [] T004 [P] Create MapSearchResult entity in `lib/features/map/domain/entities/map_search_result.dart`
- [] T005 [P] Create MapRoute entity in `lib/features/map/domain/entities/map_route.dart`
- [] T006 [P] Create MapSearchRepository interface in `lib/features/map/domain/repositories/map_search_repository.dart`
- [] T007 [P] Create MapRouteRepository interface in `lib/features/map/domain/repositories/map_route_repository.dart`
- [] T008 [P] Implement MapSearchRemoteDatasource in `lib/features/map/data/datasources/map_search_remote_datasource.dart`
- [] T009 [P] Implement MapRouteRemoteDatasource in `lib/features/map/data/datasources/map_route_remote_datasource.dart`
- [] T010 Implement MapSearchRepositoryImpl in `lib/features/map/data/repositories/map_search_repository_impl.dart`
- [] T011 Implement MapRouteRepositoryImpl in `lib/features/map/data/repositories/map_route_repository_impl.dart`
- [] T012 Create MapState in `lib/features/map/presentation/cubit/map_state.dart`
- [] T013 Create MapCubit in `lib/features/map/presentation/cubit/map_cubit.dart`
- [] T014 Update Dependency Injection in `lib/features/map/di/map_di.dart`
- [] T015 Write Unit Tests for MapCubit in `test/features/map/cubit/map_cubit_test.dart`
- [] T016 Write Unit Tests for MapSearchRepository in `test/features/map/data/map_search_repository_test.dart`
- [] T017 Write Unit Tests for MapRouteRepository in `test/features/map/data/map_route_repository_test.dart`

## Phase 2: Markers & Bottom Sheet

- [] T018 [P] [US1] Add Category icon assets in `assets/icons/map/` and update `pubspec.yaml`
- [] T019 [P] [US1] Create MapMarkerPainter in `lib/features/map/presentation/widgets/map_marker_painter.dart`
- [] T020 [US1] Refactor MapScreen to render markers in `lib/features/map/presentation/screens/map_screen.dart`
- [] T021 [US2] Refactor PlaceInfoBottomSheet in `lib/features/map/presentation/widgets/place_info_bottom_sheet.dart`

## Phase 3: Search & Relocate

- [] T022 [P] [US3] Create MapSearchOverlay in `lib/features/map/presentation/screens/map_search_overlay.dart`
- [] T023 [US3] Refactor MapSearchBar to integrate search overlay in `lib/features/map/presentation/widgets/map_search_bar.dart`
- [] T024 [P] [US4] Create MapRelocateButton in `lib/features/map/presentation/widgets/map_relocate_button.dart`
- [] T025 [US3] Integrate Search and Relocate in `lib/features/map/presentation/screens/map_screen.dart`

## Phase 4: Navigation

- [] T026 [P] [US5] Create MapNavigationBar in `lib/features/map/presentation/widgets/map_navigation_bar.dart`
- [] T027 [US5] Add Navigation integration and routing methods to MapScreen in `lib/features/map/presentation/screens/map_screen.dart`
- [] T028 [US5] Implement route rendering and camera zoom logic in `lib/features/map/presentation/screens/map_screen.dart`
- [] T029 [US5] Wire MapNavigationBar into PlaceInfoBottomSheet in `lib/features/map/presentation/widgets/place_info_bottom_sheet.dart`
