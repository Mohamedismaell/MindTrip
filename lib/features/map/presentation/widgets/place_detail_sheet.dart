import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

import 'drive_tab.dart';
import 'place_tab.dart';

class PlaceDetailSheet extends StatefulWidget {
  const PlaceDetailSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PlaceDetailSheet(),
    ).then((_) {
      if (context.mounted) {
        context.read<MapCubit>().dismissBottomSheet();
      }
    });
  }

  @override
  State<PlaceDetailSheet> createState() => _PlaceDetailSheetState();
}

class _PlaceDetailSheetState extends State<PlaceDetailSheet> {
  late final ScrollController _imagesScrollController;
  late final DraggableScrollableController _dragController;
  int _currentTab = 0;

  @override
  void initState() {
    _imagesScrollController = ScrollController();
    _dragController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _dragController.dispose();
    _imagesScrollController.dispose();
    super.dispose();
  }

  Future<void> _switchToTab(int tab) async {
    if (_currentTab != tab) {
      if (mounted) setState(() => _currentTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) => !prev.isRouteLoading && curr.isRouteLoading,
          listener: (context, state) => _switchToTab(1),
        ),
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) =>
              prev.activeRoute != null &&
              curr.activeRoute == null &&
              !curr.isRouteLoading,
          listener: (context, state) => _switchToTab(0),
        ),
      ],
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          final place = state.selectedPlace;
          final googlePlace = state.selectedGooglePlace;
          final photoUrls = state.selectedPlacePhotoUrls;

          return DraggableScrollableSheet(
            controller: _dragController,
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [AppShadows.mainElevationButton],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  child: Column(
                    children: [
                      _buildHandle(),
                      _buildTabBar(context),
                      Divider(height: 1.h, color: Colors.grey.shade200),
                      Expanded(
                        child: CustomScrollView(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _currentTab == 0
                                    ? PlaceTab(
                                        key: const ValueKey(0),
                                        place: place,
                                        googlePlace: googlePlace,
                                        photoUrls: photoUrls,
                                        imagesScrollController: _imagesScrollController,
                                        dragController: _dragController,
                                      )
                                    : const DriveTab(key: ValueKey(1)),
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      child: Center(
        child: Container(
          width: 50.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2.5.r),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildTabItem(context, 'Place', Icons.place_outlined, 0),
          SizedBox(width: 12.w),
          _buildTabItem(context, 'Drive', Icons.directions_car_outlined, 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, IconData icon, int index) {
    final isSelected = _currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _switchToTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? context.colorTheme.primary : Colors.transparent,
                width: 2.5.w,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected ? context.colorTheme.primary : context.colorTheme.outline,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: isSelected ? context.colorTheme.primary : context.colorTheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
