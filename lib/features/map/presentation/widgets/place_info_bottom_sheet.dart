import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_actions.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_images.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  const PlaceInfoBottomSheet({super.key});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void dispose() {
    _dragController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) {
        return previous.selectedPlace != current.selectedPlace ||
            previous.selectedGooglePlace != current.selectedGooglePlace ||
            previous.selectedPlacePhotoUrls != current.selectedPlacePhotoUrls ||
            previous.isBottomSheetVisible != current.isBottomSheetVisible;
      },
      builder: (context, state) {
        final isVisible = state.isBottomSheetVisible;
        final place = state.selectedPlace;
        final googlePlace = state.selectedGooglePlace;
        final photoUrls = state.selectedPlacePhotoUrls;

        return DraggableScrollableSheet(
          controller: _dragController,
          initialChildSize: isVisible ? 0.45 : 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.45,
          snap: true,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLightGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: googlePlace != null
                  ? _buildGooglePlaceContent(
                      context,
                      scrollController,
                      googlePlace,
                      photoUrls,
                    )
                  : place != null
                  ? _buildContent(context, scrollController, place)
                  : const SizedBox(),
            );
          },
        );
      },
    );
  }

  Widget _buildGooglePlaceContent(
    BuildContext context,
    ScrollController scrollController,
    GooglePlaceEntity place,
    List<String>? photoUrls,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 20.h),
              children: [
                //! bad UI & UX
                if (photoUrls != null && photoUrls.isNotEmpty)
                  PlaceImages(
                    photoUrls: photoUrls,
                    scrollController: _scrollController,
                  ),

                //Name & Category & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          place.displayName,
                          style: context.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 8.h),
                        if (place.rating != null) ...[
                          Row(
                            children: [
                              RatingStars(rating: place.rating!, size: 22.sp),
                              SizedBox(width: 4.h),
                              Text(
                                place.rating.toString(),
                                style: context.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 8.h),
                        if (place.userRatingCount != null &&
                            place.userRatingCount! > 0)
                          Text(
                            '${place.userRatingCount} Reviews ',
                            style: AppTextStyles.h8SemiBold,
                          ),
                        // : const SizedBox(),
                      ],
                    ),
                    const Spacer(),
                    if (place.primaryType != null)
                      Chip(
                        label: Text(
                          place.primaryType!.replaceAll('_', ' '),
                          style: context.textTheme.labelLarge,
                        ),
                        backgroundColor: context.colorTheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        side: BorderSide.none,
                      ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Description
                if (place.editorialSummary != null)
                  Text(
                    place.editorialSummary!,
                    style: context.textTheme.bodyMedium,
                  ),
                // Opening Hours
                if (place.openingHours != null)
                  Text(
                    place.openingHours!.openNow == true ? 'Open Now' : 'Closed',
                    style: AppTextStyles.h8SemiBold.copyWith(
                      color: place.openingHours!.openNow == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                SizedBox(height: 24.h),

                // // Address
                // if (place.formattedAddress != null)
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Icon(
                //         Icons.location_on,
                //         color: context.colorTheme.primary,
                //         size: 20.sp,
                //       ),
                //       SizedBox(width: 8.w),
                //       Expanded(
                //         child: Text(
                //           place.formattedAddress!,
                //           style: context.textTheme.bodySmall,
                //         ),
                //       ),
                //     ],
                //   ),
                // SizedBox(height: 16.h),
                PlaceActions(
                  latitude: place.latitude,
                  longitude: place.longitude,
                  dragController: _dragController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ScrollController scrollController,
    PlaceModel place,
  ) {
    final photoUrls = place.imageUrls;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 20.h),
              children: [
                //! bad UI & UX
                if (photoUrls != null)
                  PlaceImages(
                    photoUrls: photoUrls,
                    scrollController: _scrollController,
                  ),

                //Name & Category & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          place.name,
                          style: context.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 8.h),
                        if (place.rating != null) ...[
                          Row(
                            children: [
                              RatingStars(rating: place.rating!, size: 22.sp),
                              SizedBox(width: 4.h),
                              Text(
                                place.rating.toString(),
                                style: context.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 8.h),
                        // if (place.userRatingCount != null &&
                        //     place.userRatingCount! > 0)
                        //   Text(
                        //     '${place.userRatingCount} Reviews ',
                        //     style: AppTextStyles.h8SemiBold,
                        //   ),
                        // : const SizedBox(),
                      ],
                    ),
                    // const Spacer(),
                    // if (place.primaryType != null)
                    //   Chip(
                    //     label: Text(
                    //       place.primaryType!.replaceAll('_', ' '),
                    //       style: context.textTheme.labelLarge,
                    //     ),
                    //     backgroundColor: context.colorTheme.primary.withValues(
                    //       alpha: 0.2,
                    //     ),
                    //     side: BorderSide.none,
                    //   ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Description
                // if (place.editorialSummary != null)
                //   Text(
                //     place.editorialSummary!,
                //     style: context.textTheme.bodyMedium,
                //   ),
                // // Opening Hours
                // if (place.openingHours != null)
                //   Text(
                //     place.openingHours!.openNow == true ? 'Open Now' : 'Closed',
                //     style: AppTextStyles.h8SemiBold.copyWith(
                //       color: place.openingHours!.openNow == true
                //           ? Colors.green
                //           : Colors.red,
                //     ),
                //   ),
                SizedBox(height: 24.h),

                PlaceActions(
                  latitude: place.location.latitude,
                  longitude: place.location.longitude,
                  dragController: _dragController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
