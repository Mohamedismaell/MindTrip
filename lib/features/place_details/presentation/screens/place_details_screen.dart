import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_header.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_image_cover.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_info_chips.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_location_section.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_nearby_places.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_overview.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_photo_strip.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_reviews.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_trip_button.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_visit_info.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Minimal skeletal entity to build the structure without fake data strings
const _skeletalPlace = PlaceEntity(
  id: '',
  name: 'Place Name Placeholder',
  description:
      'This is a long description placeholder that will be skeletonized. It should span multiple lines to show the effect properly.',
  location: LocationEntity(address: 'City, Country', latitude: 0, longitude: 0),
  rating: 5.0,
  reviewCount: 0,
);

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        buildWhen: (previous, current) =>
            previous.placeDetailsStatus != current.placeDetailsStatus ||
            previous.place != current.place ||
            previous.preview != current.preview ||
            previous.errorMessage != current.errorMessage,
        builder: (context, state) {
          if (state.placeDetailsStatus == PlaceDetailsStatus.error) {
            return _PlaceDetailsError(
              message: state.errorMessage ?? 'Failed to load details',
            );
          }

          final place = state.place ?? state.preview ?? _skeletalPlace;
          final isMainLoading =
              state.placeDetailsStatus == PlaceDetailsStatus.loading &&
              state.place == null;

          return _PlaceDetailsBody(place: place, isMainLoading: isMainLoading);
        },
      ),
    );
  }
}

class _PlaceDetailsBody extends StatelessWidget {
  final PlaceEntity place;
  final bool isMainLoading;

  const _PlaceDetailsBody({required this.place, required this.isMainLoading});

  @override
  Widget build(BuildContext context) {
    final imageUrls = place.imageUrls ?? const <String>[];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PlaceDetailsImageCover(
                imageUrls: place.imageUrls,
                placeId: place.id,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -1.h,
                child: Container(
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.pureWhite,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeletonizer(
                    enabled: isMainLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlaceDetailsHeader(place: place),
                        SizedBox(height: 30.h),
                        PlaceDetailsInfoChips(place: place),
                        if (imageUrls.isNotEmpty || isMainLoading) ...[
                          SizedBox(height: 31.h),
                          PlaceDetailsPhotoStrip(imageUrls: imageUrls),
                        ],
                        SizedBox(height: 27.h),
                        PlaceDetailsOverview(place: place),
                        SizedBox(height: 32.h),
                        const PlaceDetailsTripButton(),
                        SizedBox(height: 30.h),
                        PlaceDetailsVisitInfo(place: place),
                        SizedBox(height: 30.h),
                        PlaceDetailsLocationSection(place: place),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  PlaceDetailsNearbyPlaces(placeId: place.id),
                  SizedBox(height: 30.h),
                  Skeletonizer(
                    enabled: isMainLoading,
                    child: PlaceDetailsReviews(place: place),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceDetailsError extends StatelessWidget {
  final String message;

  const _PlaceDetailsError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 56.r, color: AppColors.errorRed),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
