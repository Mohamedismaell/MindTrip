import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_bloc.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_event.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_state.dart';
import 'package:mindtrip/features/search/presentation/widgets/search_place_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';

class GlobalSearchScreen extends StatefulWidget {
  final String heroTag;

  const GlobalSearchScreen({super.key, this.heroTag = 'home_search_bar_hero'});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<GlobalSearchBloc>().add(const LoadNextPage());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 200;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar Header
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Row(
                children: [
                  TapScaleEffect(
                    onTap: () => context.pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        shape: BoxShape.circle,
                      ),
                      width: 38.r,
                      height: 38.r,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 24.r,
                        color: context.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Hero(
                      tag: widget.heroTag,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          decoration: BoxDecoration(
                            color: context.colorTheme.surface,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: context.colorTheme.outline.withValues(
                                alpha: 0.45,
                              ),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 20.sp,
                                color: context.colorTheme.outline,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  focusNode: _focusNode,
                                  onChanged: (query) {
                                    context.read<GlobalSearchBloc>().add(
                                      SearchQueryChanged(query),
                                    );
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'Destinations, trips, activities...',
                                    hintStyle: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontSize: 13.sp,
                                          color: context.colorTheme.outline,
                                        ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              8.horizontalSpace,
                              if (_searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    context.read<GlobalSearchBloc>().add(
                                      const ClearSearch(),
                                    );
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 20.sp,
                                    color: context.colorTheme.outline,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _searchController.text.isEmpty
                        ? Row(
                            children: [
                              12.horizontalSpace,
                              GestureDetector(
                                onTap: () async {
                                  // Unfocus keyboard before showing overlay
                                  _focusNode.unfocus();

                                  final result = await context.push<String>(
                                    AppRoutes.voiceSearch,
                                  );

                                  if (result != null && result.isNotEmpty) {
                                    _searchController.text = result;
                                    _searchController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(
                                        offset: _searchController.text.length,
                                      ),
                                    );
                                    if (mounted) {
                                      context.read<GlobalSearchBloc>().add(
                                        SearchQueryChanged(result),
                                      );
                                      setState(() {});

                                      // Optional: Refocus field if desired
                                      // _focusNode.requestFocus();
                                    }
                                  } else {
                                    // Refocus field if null/empty returned
                                    if (mounted) {
                                      _focusNode.requestFocus();
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.blueLightGradient,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.mic_rounded,
                                    color: AppColors.pureWhite,
                                    size: 22.sp,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
                builder: (context, state) {
                  if (state.status == GlobalSearchStatus.initial &&
                      state.lastQuery == null) {
                    return _buildEmptyState();
                  }

                  if (state.status == GlobalSearchStatus.loading &&
                      state.results.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == GlobalSearchStatus.error &&
                      state.results.isEmpty) {
                    return AppErrorWidget(
                      message: state.errorMessage,
                      onPressed: () {
                        context.read<GlobalSearchBloc>().add(
                          SearchQueryChanged(_searchController.text),
                        );
                      },
                    );
                  }

                  if (state.status == GlobalSearchStatus.success &&
                      state.results.isEmpty &&
                      state.lastQuery != null) {
                    return AppErrorWidget(
                      imageSize: 200,
                      title:
                          "We couldn't find any places matching '${state.lastQuery}'.",
                      message:
                          "Try adjusting your search or check your spelling.",
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.results.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                          child: Text(
                            'You might like',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              state.results.length +
                              (state.hasReachedMax ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index >= state.results.length) {
                              return Skeletonizer(
                                enabled: true,
                                child: SearchPlaceCard(
                                  place: DummyData.place,
                                  onTap: () {},
                                ),
                              );
                            }
                            final place = state.results[index];
                            return SearchPlaceCard(
                              place: place,
                              onTap: () {
                                context.read<GlobalSearchBloc>().add(
                                  SaveRecentSearch(_searchController.text),
                                );
                                //Todo maybe change to gos
                                context.push(
                                  AppRoutes.placeDetails,
                                  extra: place,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
      builder: (context, state) {
        if (state.recentSearches.isEmpty) {
          return _buildPlaceholder();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<GlobalSearchBloc>().add(
                        const ClearRecentSearches(),
                      );
                    },
                    child: Text(
                      'Clear',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: state.recentSearches.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1.h,
                  color: context.colorTheme.outline.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final search = state.recentSearches[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.history_rounded,
                      size: 20.sp,
                      color: context.colorTheme.outline,
                    ),
                    title: Text(
                      search.query,
                      style: context.textTheme.bodyMedium,
                    ),
                    onTap: () {
                      _searchController.text = search.query;
                      _searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _searchController.text.length),
                      );
                      context.read<GlobalSearchBloc>().add(
                        SearchQueryChanged(search.query),
                      );
                      setState(() {});
                    },
                    trailing: Icon(
                      Icons.north_west_rounded,
                      size: 16.sp,
                      color: context.colorTheme.outline.withValues(alpha: 0.5),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          100.verticalSpace,
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64.sp,
                  color: context.colorTheme.outline.withValues(alpha: 0.2),
                ),
                16.verticalSpace,
                Text(
                  'Search for places to explore',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorTheme.outline.withValues(alpha: 0.6),
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
