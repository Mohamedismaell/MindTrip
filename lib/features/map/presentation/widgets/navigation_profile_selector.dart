import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';

class NavigationProfileSelector extends StatefulWidget {
  const NavigationProfileSelector({super.key});

  @override
  State<NavigationProfileSelector> createState() =>
      _NavigationProfileSelectorState();
}

class _NavigationProfileSelectorState extends State<NavigationProfileSelector>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      buildWhen: (prev, curr) => prev.selectedProfile != curr.selectedProfile,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(30.r),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.centerRight,

                child: ClipRect(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isExpanded ? 1 : 0,

                    child: isExpanded
                        ? Padding(
                            padding: EdgeInsets.only(left: 8.w),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: NavigationProfile.values.map((profile) {
                                final isSelected =
                                    state.selectedProfile == profile;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),

                                  child: _ProfileChip(
                                    profile: profile,
                                    isSelected: isSelected,
                                    onTap: () {
                                      context
                                          .read<MapNavigationCubit>()
                                          .setProfile(profile);
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },

                child: Container(
                  width: 56.w,
                  height: 56.h,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: context.colorTheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [AppShadows.mainElevationButton],
                  ),

                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    turns: isExpanded ? 0.5 : 0,

                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18.sp,
                      color: context.colorTheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final NavigationProfile profile;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProfileChip({
    required this.profile,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,

        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),

        decoration: BoxDecoration(
          color: isSelected ? context.colorTheme.primary : Colors.transparent,

          borderRadius: BorderRadius.circular(12.r),
        ),

        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: isSelected ? 1.05 : 1,

          child: Icon(
            profile.icon,
            size: isSelected ? 20.sp : 18.sp,

            color: isSelected
                ? context.colorTheme.onPrimary
                : context.colorTheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
