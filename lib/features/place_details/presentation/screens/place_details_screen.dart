import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
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

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (context, state) {
          if (state.status == PlaceDetailsStatus.loading &&
              state.preview == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PlaceDetailsStatus.error) {
            return _PlaceDetailsError(
              message: state.errorMessage ?? 'Failed to load details',
            );
          }

          final place = state.place ?? state.preview;
          if (place == null) {
            return const Center(child: Text('Place not found'));
          }

          return _PlaceDetailsBody(place: place, state: state);
        },
      ),
    );
  }
}

class _PlaceDetailsBody extends StatelessWidget {
  final PlaceModel place;
  final PlaceDetailsState state;

  const _PlaceDetailsBody({required this.place, required this.state});

  @override
  Widget build(BuildContext context) {
    final imageUrls = place.imageUrls ?? const <String>[];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth > 500.w ? 430.w : double.infinity;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: PlaceDetailsImageCover(
                    imageUrls: place.imageUrls.first,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: Offset(0, -30.h),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.r),
                          topRight: Radius.circular(28.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 18.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PlaceDetailsHeader(place: place),
                            SizedBox(height: 24.h),
                            PlaceDetailsInfoChips(place: place),
                            SizedBox(height: 24.h),
                            PlaceDetailsPhotoStrip(imageUrls: imageUrls),
                            SizedBox(height: 24.h),
                            PlaceDetailsOverview(place: place),
                            SizedBox(height: 24.h),
                            const PlaceDetailsTripButton(),
                            SizedBox(height: 26.h),
                            PlaceDetailsVisitInfo(place: place),
                            SizedBox(height: 26.h),
                            PlaceDetailsLocationSection(place: place),
                            SizedBox(height: 28.h),
                            PlaceDetailsNearbyPlaces(
                              places: state.nearbyPlaces,
                              isLoading: state.isNearbyLoading,
                            ),
                            SizedBox(height: 28.h),
                            PlaceDetailsReviews(place: place),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
