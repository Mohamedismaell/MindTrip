import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/drive_tab.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_tab.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  const PlaceInfoBottomSheet({super.key});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
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
      setState(() => _currentTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) =>
              !prev.isRouteLoading && curr.isRouteLoading,
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
        buildWhen: (previous, current) {
          return previous.selectedPlace != current.selectedPlace ||
              previous.selectedGooglePlace != current.selectedGooglePlace ||
              previous.selectedPlacePhotoUrls !=
                  current.selectedPlacePhotoUrls ||
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
                  boxShadow: [AppShadows.mainElevationButton],
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHandle(),
                          _buildTabBar(context),
                          Divider(height: 1.h, color: Colors.grey.shade200),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                            child: child,
                          );
                        },
                        //* this fix the slide up animaiton bug.
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: [...previousChildren, ?currentChild],
                          );
                        },

                        child: _currentTab == 0
                            ? PlaceTab(
                                key: ValueKey(0),
                                place: place,
                                googlePlace: googlePlace,
                                photoUrls: photoUrls,
                                imagesScrollController: _imagesScrollController,
                                dragController: _dragController,
                              )
                            : const DriveTab(key: ValueKey(1)),
                      ),
                    ),
                  ],
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

  //  Tab Bar

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

  Widget _buildTabItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
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
                color: isSelected
                    ? context.colorTheme.primary
                    : Colors.transparent,
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
                color: isSelected
                    ? context.colorTheme.primary
                    : context.colorTheme.outline,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: isSelected
                      ? context.colorTheme.primary
                      : context.colorTheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
