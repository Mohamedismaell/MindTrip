import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_snackbar.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_bloc.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_event.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_state.dart';

class MapSearchOverlay extends StatefulWidget {
  const MapSearchOverlay({super.key});

  @override
  State<MapSearchOverlay> createState() => _MapSearchOverlayState();
}

class _MapSearchOverlayState extends State<MapSearchOverlay> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<MapSearchBloc>().add(
      SearchQueryChanged(_searchController.text),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Hero(
                tag: 'map_search_bar',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      boxShadow: [AppShadows.mainElevationButton],
                      color: context.colorTheme.surface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: [
                        TapScaleEffect(
                          onTap: () {
                            context.read<MapSearchBloc>().add(
                              const SearchCleared(),
                            );
                            context.pop();
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLightGray,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 24.sp,
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Looking for a place...',
                              hintStyle: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: context.colorTheme.outline,
                                size: 24.sp,
                              ),
                              // suffixIcon: _searchController.text.isNotEmpty
                              //     ? TapScaleEffect(
                              //         onTap: () {
                              //           _searchController.clear();
                              //           context
                              //               .read<MapSearchCubit>()
                              //               .clearSearch();
                              //         },
                              //         child: Icon(
                              //           Icons.clear,
                              //           color: context.colorTheme.outline,
                              //           size: 20.sp,
                              //         ),
                              //       )
                              //     : null,
                            ),
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Search Results
            Expanded(
              child: BlocConsumer<MapSearchBloc, MapSearchState>(
                listenWhen: (previous, current) =>
                    previous.autocompleteStatus != current.autocompleteStatus ||
                    previous.placeDetailsStatus != current.placeDetailsStatus,
                listener: (context, state) {
                  if (state.autocompleteStatus == MapSearchStatus.error) {
                    AppSnackBar.showError(
                      context: context,
                      message: state.autocompleteErrorMessage!,
                    );
                  }
                  if (state.placeDetailsStatus == MapSearchStatus.error) {
                    AppSnackBar.showError(
                      context: context,
                      message: state.placeDetailsErrorMessage!,
                    );
                  }
                  // Dismiss overlay when a place has been resolved
                  if (state.placeDetailsStatus == MapSearchStatus.success &&
                      state.resolvedSearchPlace != null) {
                    context.pop();
                  }
                  // if (state.resolvedSearchPlace != null) {
                  //   context.pop();
                  // }
                },
                builder: (context, state) {
                  if (state.isAutocompletLoading &&
                      state.autocompletePredictions.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.autocompletePredictions.isEmpty ||
                      _searchController.text.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.travel_explore,
                              size: 64.sp,
                              color: context.colorTheme.outline,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No places found',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.autocompletePredictions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.autocompletePredictions[index];
                      return ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: context.colorTheme.primaryContainer
                                .withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: context.colorTheme.primary,
                          ),
                        ),
                        title: Text(
                          suggestion.primaryText,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: suggestion.secondaryText.isNotEmpty
                            ? Text(
                                suggestion.secondaryText,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorTheme.outline,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        onTap: () {
                          context.read<MapSearchBloc>().add(
                            PredictionSelected(suggestion.placeId),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
