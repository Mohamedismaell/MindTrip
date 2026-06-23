import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/wavy_clipper.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';

class TripShareCard extends StatelessWidget {
  final Trip trip;
  final TripItinerary? itinerary;

  const TripShareCard({super.key, required this.trip, this.itinerary});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM MMM yyyy');
    final dateRange = trip.tripStart != null && trip.tripEnd != null
        ? '${DateFormat('d').format(trip.tripStart!)}-${dateFormat.format(trip.tripEnd!)}'
        : 'TBD';

    return Container(
      width: 450,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: SmoothWavyClipper(),
            child: SizedBox(
              height: 480,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  AppCachedImage(
                    imagePath: trip.itineraryCoverUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 32,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.planeLogo, width: 30),

                            SizedBox(width: 8),
                            Text(
                              'MindTrip',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h4SemiBold.copyWith(
                                color: AppColors.pureBlack,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          textAlign: TextAlign.center,
                          'Your journey, perfectly planned.',
                          style: AppTextStyles.h10Medium.copyWith(
                            color: AppColors.pureBlack,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 45, // Adjusted for wave height
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Let's go to",
                              style: AppTextStyles.h5Regular.copyWith(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.flight_takeoff,
                              color: AppColors.testBlue,
                              size: 28,
                            ),
                          ],
                        ),
                        Text(
                          trip.destination,
                          style: AppTextStyles.h3Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.testBlue,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              trip.destination,
                              style: AppTextStyles.h8Medium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _TripShareInfoItem(
                  icon: Icons.calendar_month,
                  label: 'DATES',
                  value: dateRange,
                ),
                const _TripShareVerticalDivider(),
                _TripShareInfoItem(
                  icon: Icons.wb_sunny_outlined,
                  label: 'DURATION',
                  value: '${trip.durationDays} Days',
                ),
                const _TripShareVerticalDivider(),
                _TripShareInfoItem(
                  icon: Icons.location_on,
                  label: 'PLACES',
                  value:
                      '${itinerary?.totalPlaces ?? trip.placePreviews.length} Places',
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLightGray,
                      // color: Color(0xFFE0E7FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.format_quote,
                      color: AppColors.testBlue,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New places, new memories,',
                          style: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        ),
                        Text(
                          'the best stories start with a plan.',
                          style: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SvgPicture.asset(AppAssets.travelIllustration, width: 90),
                ],
              ),
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: const Divider(
              color: Color(0xFFF3F4F6),
              height: 1,
              thickness: 1,
            ),
          ),

          // 4. Footer Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.planeLogo, width: 18),
                // Container(
                //   padding: EdgeInsets.all(4),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     shape: BoxShape.circle,
                //     border: Border.all(color: AppColors.testBlue, width: 1.5),
                //   ),
                //   child: Icon(
                //     Icons.airplanemode_active,
                //     color: AppColors.testBlue,
                //     size: 14,
                //   ),
                // ),
                SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.h9Medium.copyWith(
                      color: const Color(0xFF9CA3AF),
                    ),
                    children: [
                      const TextSpan(text: 'Planned with '),
                      TextSpan(
                        text: 'MindTrip',
                        style: TextStyle(
                          color: AppColors.testBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripShareInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _TripShareInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.testBlue, size: 20),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  label,
                  style: AppTextStyles.h10SemiBold.copyWith(
                    fontSize: 10,
                    color: AppColors.mediumLightGray,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  textAlign: TextAlign.center,
                  value,
                  style: AppTextStyles.h10Bold.copyWith(
                    fontSize: 10,
                    color: AppColors.pureBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripShareVerticalDivider extends StatelessWidget {
  const _TripShareVerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 1,
      color: const Color(0xFFE5E7EB),
      margin: EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
