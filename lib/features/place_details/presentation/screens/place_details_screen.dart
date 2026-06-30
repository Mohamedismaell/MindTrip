import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_header.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_image_cover.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_info_chips.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_location_section.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_overview.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_nearby_places.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_photo_strip.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_reviews.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_visit_info.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/place_details_trip_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final String? heroTag;
  const PlaceDetailsScreen({super.key, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
        listenWhen: (previous, current) =>
            previous.placeDetailsStatus != current.placeDetailsStatus &&
            current.placeDetailsStatus == PlaceDetailsStatus.loaded,
        listener: (context, state) {
          if (state.place != null) {
            context.read<PlaceDetailsCubit>().loadFirstPageNearbyPlaces(
              state.place!.id,
              lat: state.place!.location.latitude,
              lng: state.place!.location.longitude,
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.placeDetailsStatus != current.placeDetailsStatus ||
            previous.place != current.place ||
            previous.preview != current.preview ||
            previous.nearbyError != current.nearbyError,
        builder: (context, state) {
          final place = state.place ?? state.preview ?? DummyData.placeDetails;

          return _PlaceDetailsBody(
            place: place,
            placeDetailsStatus: state.placeDetailsStatus,
            heroTag: heroTag,
          );
        },
      ),
    );
  }
}

class _PlaceDetailsBody extends StatelessWidget {
  final PlaceEntity place;
  final PlaceDetailsStatus placeDetailsStatus;
  final String? heroTag;
  const _PlaceDetailsBody({
    required this.place,
    required this.placeDetailsStatus,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrls = place.imageUrls ?? const <String>[];
    final isMainLoading = placeDetailsStatus == PlaceDetailsStatus.loading;
    final isMainError = placeDetailsStatus == PlaceDetailsStatus.error;
    return RefreshIndicator(
      color: context.colorTheme.primary,
      backgroundColor: Colors.white,
      strokeWidth: 3,
      displacement: 20,
      edgeOffset: 10,
      onRefresh: () async {
        await context.read<PlaceDetailsCubit>().loadPlaceDetails(place.id);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                PlaceDetailsImageCover(
                  imageUrls: place.imageUrls,
                  placeId: place.id,
                  place: place,
                  heroTag: heroTag,
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
          if (isMainError)
            SliverToBoxAdapter(
              child: Center(
                child: AppErrorWidget(
                  imagePath: AppAssets.errorBotMap,
                  title: 'Destination unavailable',
                  message:
                      'We couldn\'t retrieve information for this place at the moment.',
                  onPressed: () {
                    context.read<PlaceDetailsCubit>().loadPlaceDetails(
                      place.id,
                    );
                  },
                ),
              ),
            )
          else
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
                        justifyMultiLineText: true,
                        enableSwitchAnimation: true,

                        // ignorePointers: false,
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
                            if (place.description != '' &&
                                place.description != null) ...[
                              PlaceDetailsOverview(place: place),
                              SizedBox(height: 32.h),
                            ],
                            PlaceDetailsTripButton(place: place),
                            SizedBox(height: 30.h),
                            PlaceDetailsVisitInfo(place: place),
                            SizedBox(height: 30.h),
                            PlaceDetailsLocationSection(place: place),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      PlaceDetailsNearbyPlaces(currentPlace: place),
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
      ),
    );
  }
}
