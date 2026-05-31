import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_header.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_image_carousel.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_info_chips.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_location_section.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_nearby_places.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_overview.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (context, state) {
          if (state.status == PlaceDetailsStatus.loading && state.preview == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PlaceDetailsStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.errorMessage ?? 'Failed to load details'),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final place = state.place ?? state.preview;

          if (place == null) {
            return const Center(child: Text('Place not found'));
          }

          return CustomScrollView(
            slivers: [
              // Hero images
              SliverToBoxAdapter(
                child: PlaceDetailsImageCarousel(imageUrls: place.imageUrls ?? []),
              ),
              // Content
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    PlaceDetailsHeader(place: place),
                    SizedBox(height: 24.h),
                    
                    PlaceDetailsInfoChips(place: place),
                    SizedBox(height: 24.h),
                    
                    PlaceDetailsOverview(place: place),
                    SizedBox(height: 24.h),
                    
                    PlaceDetailsLocationSection(place: place),
                    SizedBox(height: 32.h),
                    
                    PlaceDetailsNearbyPlaces(
                      places: state.nearbyPlaces, 
                      isLoading: state.isNearbyLoading
                    ),
                    SizedBox(height: 80.h), // bottom padding for floating action button
                  ]),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Wire up to trip adding feature in a later phase
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            child: const Text(
              'Add to Trip',
              style: TextStyle(color: AppColors.pureWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
