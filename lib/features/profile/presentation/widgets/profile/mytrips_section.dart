import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class MyTripsSection extends StatefulWidget {
  const MyTripsSection({super.key});

  @override
  State<MyTripsSection> createState() => _MyTripsSectionState();
}

class _MyTripsSectionState extends State<MyTripsSection> {
  @override
  void initState() {
    super.initState();
    sl<TripsCubit>().loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<TripsCubit>(),
      child: BlocBuilder<TripsCubit, TripsState>(
        builder: (context, tripsState) {
          final trips = tripsState.trips;
          if (trips.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text(
                  'No trips generated yet.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              ),
            );
          }
          return SizedBox(
            height: 233.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: trips.length,
              separatorBuilder: (_, _) => SizedBox(width: 32.w),
              itemBuilder: (context, index) {
                return _MyTripCard(
                  trip: trips[index],
                  onTap: () {
                    //Todo: Handle the navigaiton works but with silly way
                    if (trips[index].status == TripStatus.inProgress) {
                      context.push(
                        '${AppRoutes.tripDetails}?tripId=${trips[index].id}',
                      );
                    } else if (trips[index].status == TripStatus.draft) {
                      if (trips[index].placePreviews.isEmpty) {
                        context.push(
                          '${AppRoutes.aiPlannerFlow}?tripId=${trips[index].id}',
                        );
                      } else {
                        context.push(
                          '${AppRoutes.tripDetails}?tripId=${trips[index].id}',
                        );
                      }
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MyTripCard extends StatelessWidget {
  const _MyTripCard({required this.trip, this.onTap});

  final Trip trip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: SizedBox(
          width: 205.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCachedImage(
                imagePath: trip.itineraryCoverUrl ?? trip.coverAsset,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 4),
                    child: Container(
                      height: 72.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      color: Colors.black.withValues(alpha: 0.22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              trip.title,
                              style: AppTextStyles.h8Bold.copyWith(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Expanded(
                            child: Text(
                              trip.destination,
                              style: AppTextStyles.h9Bold.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.primaryLightGray,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
