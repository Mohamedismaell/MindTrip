import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_card_overview_map.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../cubit/map_cubit.dart';
import 'place_tab.dart';
import 'drive_tab.dart';
import '../cubit/map_state.dart';

class PlaceCardRow extends StatefulWidget {
  const PlaceCardRow({super.key});

  @override
  State<PlaceCardRow> createState() => _PlaceCardRowState();
}

class _PlaceCardRowState extends State<PlaceCardRow> {
  late final PageController _pageController;

  int _currentPage = 0;
  int _lastPulse = 0;
  String? _lastSelectedPlaceId;
  List<MapAnnotationEntry>? _lastAnnotations;

  final Set<String> _removingPlaceIds = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _jumpToIndex(int index) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final collapsedCardHeight = screenHeight * 0.29;

    final expandedCardHeight = screenHeight * 0.5;

    final imageHeight = screenHeight * 0.12;

    final contentHeight = collapsedCardHeight - imageHeight;

    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (prev, curr) =>
          prev.selectedPlace != curr.selectedPlace ||
          prev.annotations != curr.annotations ||
          prev.isBottomSheetVisible != curr.isBottomSheetVisible ||
          prev.navigationPulse != curr.navigationPulse,
      listener: (context, state) {
        if (_lastAnnotations != null && _lastAnnotations != state.annotations) {
          _currentPage = 0;
          _jumpToIndex(0);
        }
        _lastAnnotations = state.annotations;

        final pulseTriggered = state.navigationPulse > _lastPulse;
        _lastPulse = state.navigationPulse;

        final selectionChanged =
            state.selectedPlace?.id != _lastSelectedPlaceId;
        _lastSelectedPlaceId = state.selectedPlace?.id;

        if (pulseTriggered) {
          if (_currentPage != 0) {
            _currentPage = 0;
            _jumpToIndex(0);
          }
        } else if (selectionChanged) {
          if (state.selectedPlace != null) {
            final index = state.annotations.indexWhere(
              (a) => a.place.id == state.selectedPlace!.id,
            );

            if (index != -1) {
              final targetIndex = index + 1;
              if (targetIndex != _currentPage) {
                _currentPage = targetIndex;
                _jumpToIndex(targetIndex);
              }
            }
          } else {
            if (_currentPage != 0) {
              _currentPage = 0;
              _jumpToIndex(0);
            }
          }
        }
      },
      buildWhen: (prev, curr) =>
          prev.annotations != curr.annotations ||
          prev.selectedPlace != curr.selectedPlace ||
          prev.isBottomSheetVisible != curr.isBottomSheetVisible ||
          prev.selectedGooglePlace != curr.selectedGooglePlace ||
          prev.selectedPlacePhotoUrls != curr.selectedPlacePhotoUrls,
      builder: (context, state) {
        if (state.annotations.isEmpty) {
          return const SizedBox.shrink();
        }

        final isExpanded = state.isBottomSheetVisible;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isExpanded ? expandedCardHeight : collapsedCardHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: state.annotations.length + 1,
            onPageChanged: (index) {
              _currentPage = index;

              // if (_isUserSwipe) {
              //   if (index > 0) {
              //     // final entry = state.annotations[index - 1];
              //     // context.read<MapCubit>().selectPlace(entry.place.id);
              //   } else {
              //     context.read<MapCubit>().clearSelection();
              //   }
              // }
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return BuildDriveCard(
                  isExpanded: isExpanded,
                  isRouteSelected: state.selectedPlace == null,
                  expandedHeight: expandedCardHeight,
                  collapsedHeight: collapsedCardHeight,
                  onTap: () => _jumpToIndex(0),
                );
              }
              final entry = state.annotations[index - 1];

              final place = entry.place;

              final isSelected = state.selectedPlace?.id == place.id;

              final imageUrl =
                  (place.imageUrls != null && place.imageUrls!.isNotEmpty)
                  ? place.imageUrls!.first
                  : null;

              final googlePlace =
                  entry.googlePlace ??
                  (isSelected ? state.selectedGooglePlace : null);

              final statePhotoUrls = isSelected
                  ? state.selectedPlacePhotoUrls
                  : null;

              final finalPhotoUrls =
                  statePhotoUrls != null && statePhotoUrls.isNotEmpty
                  ? statePhotoUrls
                  : place.imageUrls;

              final isRemoving = _removingPlaceIds.contains(place.id);

              return Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isRemoving ? 0 : 1,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isRemoving ? .8 : 1,
                    child: TapScaleEffect(
                      onTap: () => isSelected && isExpanded
                          ? context.read<MapCubit>().dismissBottomSheet()
                          : context.read<MapCubit>().selectPlace(place.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: isSelected && isExpanded
                            ? expandedCardHeight
                            : collapsedCardHeight,
                        margin: EdgeInsets.only(
                          right: 8.w,
                          top: 10.h,
                          bottom: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [AppShadows.mapToolButtons],
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21.5.r),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21.5.r),
                            child: Stack(
                              children: [
                                IgnorePointer(
                                  ignoring: isSelected && isExpanded,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 250),
                                    opacity: isSelected && isExpanded ? 0 : 1,
                                    child: PlaceCardOverviewMap(
                                      place: place,
                                      imageUrl: imageUrl,
                                      imageHeight: imageHeight,
                                      contentHeight: contentHeight,
                                      isSearchResult: entry.isSearchResult,
                                      heroTag: (isSelected && isExpanded)
                                          ? null
                                          : 'map_${place.id}',
                                      onAdd: () {
                                        setState(() {
                                          _removingPlaceIds.add(place.id);
                                        });
                                      },
                                      onRemove: () {
                                        setState(() {
                                          _removingPlaceIds.remove(place.id);
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                IgnorePointer(
                                  ignoring: !(isSelected && isExpanded),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 250),
                                    opacity: isSelected && isExpanded ? 1 : 0,
                                    child: PlaceTab(
                                      place: place,
                                      googlePlace: googlePlace,
                                      photoUrls: finalPhotoUrls,
                                      heroTag: (isSelected && isExpanded)
                                          ? 'map_${place.id}'
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildDriveCard extends StatelessWidget {
  const BuildDriveCard({
    super.key,
    required this.isExpanded,
    required this.isRouteSelected,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.onTap,
  });
  final bool isExpanded;
  final bool isRouteSelected;
  final double expandedHeight;
  final double collapsedHeight;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    bool showExpanded = isExpanded && isRouteSelected;

    return TapScaleEffect(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: showExpanded ? expandedHeight : collapsedHeight,
          margin: EdgeInsets.only(right: 8.w, top: 10.h, bottom: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [AppShadows.mapToolButtons],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21.5.r),
            child: const SingleChildScrollView(child: DriveTab()),
          ),
        ),
      ),
    );
  }
}
