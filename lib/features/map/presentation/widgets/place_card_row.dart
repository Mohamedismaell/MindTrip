import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/location/cubit/location_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_action_button.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_navigation_cubit.dart';
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
  bool _isUserSwipe = true;
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

    _isUserSwipe = false;

    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        )
        .then((_) => _isUserSwipe = true);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final collapsedCardHeight = screenHeight * 0.28;

    final expandedCardHeight = screenHeight * 0.5;

    final imageHeight = screenHeight * 0.12;

    final contentHeight = collapsedCardHeight - imageHeight;

    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (prev, curr) =>
          prev.selectedPlace != curr.selectedPlace ||
          prev.annotations != curr.annotations,
      listener: (context, state) {
        // Reset to the first card when the annotation list is replaced
        // (e.g. switching trip day or loading a new place set).
        if (_lastAnnotations != null && _lastAnnotations != state.annotations) {
          _currentPage = 0;
          _jumpToIndex(0);
        }
        _lastAnnotations = state.annotations;

        if (state.selectedPlace != null) {
          final index = state.annotations.indexWhere(
            (a) => a.place.id == state.selectedPlace!.id,
          );

          // Add 1 to account for the DriveTab
          if (index != -1) {
            final targetIndex = index + 1;
            if (targetIndex != _currentPage) {
              _jumpToIndex(targetIndex);
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

              // When the user swipes to a place card, select it and fly to it.
              if (_isUserSwipe && index > 0) {
                final entry = state.annotations[index - 1];
                //! we Can close it if its bad UX
                context.read<MapCubit>().selectPlace(entry.place.id);
              }
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildDriveCard(
                  context,
                  isExpanded,
                  expandedCardHeight,
                  collapsedCardHeight,
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
                    child: GestureDetector(
                      onTap: () {
                        if (isSelected && isExpanded) {
                          context.read<MapCubit>().dismissBottomSheet();
                        } else {
                          context.read<MapCubit>().selectPlace(place.id);
                        }
                      },
                      child: Container(
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
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21.5.r),
                          child: (isSelected && isExpanded)
                              ? Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: PlaceTab(
                                        place: place,
                                        googlePlace: googlePlace,
                                        photoUrls: finalPhotoUrls,
                                        imagesScrollController:
                                            ScrollController(),
                                      ),
                                    ),

                                    Positioned(
                                      top: 12.h,
                                      right: 12.w,
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<MapCubit>()
                                              .dismissBottomSheet();
                                        },
                                        child: Container(
                                          width: 32.w,
                                          height: 32.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              AppShadows.tourPackagesCard,
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 24.sp,
                                            color: context.colorTheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : _buildCardOverview(
                                  context,
                                  place,
                                  imageUrl,
                                  imageHeight,
                                  contentHeight,
                                  entry.isSearchResult,
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

  Widget _buildCardOverview(
    BuildContext context,
    PlaceModel place,
    String? imageUrl,
    double imageHeight,
    double contentHeight,
    bool isSearchResult,
  ) {
    final placeLat = place.location.latitude;

    final placeLng = place.location.longitude;

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: Hero(
                tag: 'place-${place.id}',
                transitionOnUserGestures: true,
                child: AppCachedImage(imagePath: imageUrl, fit: BoxFit.cover),
              ),
            ),

            Positioned(
              top: 12.h,
              right: 12.w,
              child: GestureDetector(
                onTap: () {
                  context.read<MapCubit>().selectPlace(place.id);
                },
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [AppShadows.tourPackagesCard],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 24.sp,
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      place.name,
                      style: AppTextStyles.h8Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final distance = context
                          .read<LocationCubit>()
                          .getDistanceBetween(
                            placeLat: placeLat,
                            placeLng: placeLng,
                          );

                      return Text(
                        state.formatDistance(distance),
                        style: AppTextStyles.h9Medium.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      );
                    },
                  ),
                ],
              ),

              // const Spacer(),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      place.description ?? "No description available",
                      style: AppTextStyles.h10Regular.copyWith(
                        color: context.colorTheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  if (place.rating != null) ...[
                    Row(
                      children: [
                        RatingStars(rating: place.rating!, size: 18.sp),

                        SizedBox(width: 4.w),

                        Text(
                          place.rating.toString(),
                          style: AppTextStyles.h10SemiBold.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),

              // const Spacer(),
              SizedBox(height: 10.h),

              Row(
                children: [
                  Expanded(
                    child: MapActionButton(
                      label: "Show route",
                      icon: Icons.directions_rounded,
                      color: context.colorTheme.primary,
                      isFilled: true,
                      onTap: () async {
                        final pos = await sl<LocationService>()
                            .getCurrentLocation();

                        if (pos != null && context.mounted) {
                          final userPos = Position(pos.longitude, pos.latitude);

                          context.read<MapNavigationCubit>().navigateToPosition(
                            userPos,
                            placeLat,
                            placeLng,
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(width: 8.w),

                  isSearchResult
                      ? Expanded(
                          child: MapActionButton(
                            label: "Remove",
                            icon: Icons.delete_outline_rounded,
                            color: context.colorTheme.error,
                            isFilled: false,
                            onTap: () {
                              setState(() {
                                _removingPlaceIds.add(place.id);
                              });

                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  if (context.mounted) {
                                    context.read<MapCubit>().removeSearchPlace(
                                      place.id,
                                    );

                                    setState(() {
                                      _removingPlaceIds.remove(place.id);
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: MapActionButton(
                            label: "Show map",
                            icon: Icons.map_rounded,
                            color: context.colorTheme.primary,
                            isFilled: false,
                            onTap: () {
                              context.read<MapCubit>().triggerFlyTo(
                                placeLat,
                                placeLng,
                              );

                              context.read<MapCubit>().dismissBottomSheet();
                            },
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDriveCard(
    BuildContext context,
    bool isExpanded,
    double expandedHeight,
    double collapsedHeight,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: isExpanded ? expandedHeight : collapsedHeight,
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
    );
  }
}
