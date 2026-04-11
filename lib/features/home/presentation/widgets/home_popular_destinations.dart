import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomePopularDestinations extends StatelessWidget {
  const HomePopularDestinations({super.key, required this.destinations});

  final List<HomeSpotlight> destinations;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 198.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: destinations.length,

          itemBuilder: (context, index) {
            final destination = destinations[index];
            return Row(
              children: [
                Container(
                  width: 289.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.r),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppCachedImage(imageUrl: destination.imageUrl),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(color: Colors.transparent),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            right: 20.w,
                            left: 20.w,
                            top: 30.h,
                            bottom: 20.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.title,
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(color: AppColors.pureWhite),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    destination.location,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                          color: AppColors.primaryLightGray,
                                        ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  for (final previewImageUrl
                                      in destination.previewImageUrls.take(
                                        2,
                                      )) ...[
                                    _PreviewImageTile(
                                      imageUrl: previewImageUrl,
                                    ),
                                    SizedBox(width: 8.w),
                                  ],
                                  _ExtraPhotosTile(
                                    extraPhotoCount:
                                        destination.extraPhotoCount,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 20.h,
                          right: 20.w,
                          child: _CircleIcon(
                            icon: HomeAssets.blackHeartIcon,
                            size: 24,
                          ),
                        ),

                        Positioned(
                          bottom: 20.h,
                          right: 20.w,
                          child: _CircleIcon(
                            icon: HomeAssets.upTRightArrowtIcon,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CircleIcon extends StatefulWidget {
  const _CircleIcon({required this.icon, required this.size});

  final String icon;
  final double size;

  @override
  State<_CircleIcon> createState() => _CircleIconState();
}

//! need to get the full heart and replace it while tapping
//* later connect iot with the real data with cubit
class _CircleIconState extends State<_CircleIcon> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.pureWhite.withValues(alpha: 0.3),
      ),
      padding: EdgeInsets.all(12.r),
      child: InkWell(
        onTap: () => setState(() {
          isActive = !isActive;
        }),
        child: SizedBox(
          width: widget.size.w,
          height: widget.size.h,
          child: SvgPicture.asset(
            widget.icon,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.red : context.colorTheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewImageTile extends StatelessWidget {
  const _PreviewImageTile({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: SizedBox(
        width: 47.r,
        height: 47.r,
        child: AppCachedImage(imageUrl: imageUrl),
      ),
    );
  }
}

class _ExtraPhotosTile extends StatelessWidget {
  const _ExtraPhotosTile({required this.extraPhotoCount});

  final int extraPhotoCount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: 47.r,
          height: 47.r,
          alignment: Alignment.center,
          color: AppColors.pureWhite.withValues(alpha: 0.1),
          child: Text(
            '+$extraPhotoCount',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ),
    );
  }
}
