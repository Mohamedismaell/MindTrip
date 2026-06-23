import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/distance_calculator.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsNearbyPlaces extends StatefulWidget {
  final PlaceEntity currentPlace;
  const PlaceDetailsNearbyPlaces({super.key, required this.currentPlace});

  @override
  State<PlaceDetailsNearbyPlaces> createState() =>
      _PlaceDetailsNearbyPlacesState();
}

class _PlaceDetailsNearbyPlacesState extends State<PlaceDetailsNearbyPlaces> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PlaceDetailsCubit>().loadMoreNearbyPlaces(
        widget.currentPlace.id,
        lat: widget.currentPlace.location.latitude,
        lng: widget.currentPlace.location.longitude,
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 300;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
      buildWhen: (previous, current) =>
          previous.nearbyStatus != current.nearbyStatus ||
          previous.nearbyPlaces != current.nearbyPlaces,
      builder: (context, state) {
        final cubit = context.read<PlaceDetailsCubit>();
        if (state.nearbyStatus == NearbyStatus.error) {
          return AppErrorWidget(
            title: 'Nearby places unavailable',
            onPressed: () => cubit.loadFirstPageNearbyPlaces(
              widget.currentPlace.id,
              lat: widget.currentPlace.location.latitude,
              lng: widget.currentPlace.location.longitude,
            ),
          );
        }

        final isNearbyLoading = state.nearbyStatus == NearbyStatus.loading;
        final places = isNearbyLoading
            ? DummyData.nearbyPlaces
            : state.nearbyPlaces.items;

        if (!isNearbyLoading && places.isEmpty) {
          return const SizedBox.shrink();
        }

        return Skeletonizer(
          enabled: isNearbyLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton.keep(
                child: Text(
                  'Nearby Places',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColors.pureBlack,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 139.h,
                child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: isNearbyLoading
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  itemCount:
                      places.length +
                      (state.nearbyPlaces.isMoreLoading ? 1 : 0),
                  separatorBuilder: (context, index) => SizedBox(width: 18.w),
                  itemBuilder: (context, index) {
                    if (index < places.length) {
                      return _NearbyPlaceCard(
                        place: places[index],
                        currentPlace: widget.currentPlace,
                      );
                    } else {
                      return Skeletonizer(
                        enabled: true,
                        child: _NearbyPlaceCard(
                          place: DummyData.place,
                          currentPlace: widget.currentPlace,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NearbyPlaceCard extends StatelessWidget {
  final PlaceEntity place;
  final PlaceEntity currentPlace;

  const _NearbyPlaceCard({required this.place, required this.currentPlace});

  @override
  Widget build(BuildContext context) {
    final image = place.imageUrls?.first;

    final distance = DistanceCalculator.calculateDistance(
      startLat: currentPlace.location.latitude,
      startLng: currentPlace.location.longitude,
      endLat: place.location.latitude,
      endLng: place.location.longitude,
    );

    return Container(
      width: 152.w,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.colorTheme.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AppCachedImage(
              imagePath: image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.h8SemiBold.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car_filled_outlined,
                          size: 20.r,
                          color: context.colorTheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            DistanceCalculator.formatDistance(distance),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
