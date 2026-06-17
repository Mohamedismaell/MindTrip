import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

//Todo replace it with real data
class PlaceDetailsNearbyPlaces extends StatelessWidget {
  final String placeId;
  const PlaceDetailsNearbyPlaces({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
      buildWhen: (previous, current) =>
          previous.nearbyStatus != current.nearbyStatus ||
          previous.nearbyPlaces != current.nearbyPlaces,
      builder: (context, state) {
        final cubit = context.read<PlaceDetailsCubit>();
        if (state.nearbyStatus == NearbyStatus.error) {
          return AppErrorWidget.nearbyPlaces(
            onRetry: () => cubit.loadNearbyPlaces(placeId),
          );
        }

        final isNearbyLoading = state.nearbyStatus == NearbyStatus.loading;
        final places = isNearbyLoading
            ? [
                PlaceEntity(
                  id: '1',
                  name: 'Loading...',
                  location: LocationEntity(
                    address: '',
                    latitude: 0,
                    longitude: 0,
                    city: '',
                    cityEn: '',
                  ),
                ),
                PlaceEntity(
                  id: '2',
                  name: 'Loading...',
                  location: LocationEntity(
                    address: '',
                    latitude: 0,
                    longitude: 0,
                    city: '',
                    cityEn: '',
                  ),
                ),
                PlaceEntity(
                  id: '3',
                  name: 'Loading...',
                  location: LocationEntity(
                    address: '',
                    latitude: 0,
                    longitude: 0,
                    city: '',
                    cityEn: '',
                  ),
                ),
              ]
            : state.nearbyPlaces;

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
                  scrollDirection: Axis.horizontal,
                  physics: isNearbyLoading
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  itemCount: places.length,
                  separatorBuilder: (context, index) => SizedBox(width: 18.w),
                  itemBuilder: (context, index) =>
                      _NearbyPlaceCard(place: places[index]),
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

  const _NearbyPlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    final image = place.imageUrls?.isNotEmpty == true
        ? place.imageUrls!.first
        : 'assets/images/onboarding/Pyramids.webp';

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
          // SizedBox(height: 10.h),
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

                        //Todo replace it with real data
                        Expanded(
                          child: Text(
                            '0.4 km',
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
