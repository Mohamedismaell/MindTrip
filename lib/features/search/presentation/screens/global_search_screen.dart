import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_search_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
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
                      decoration: const BoxDecoration(
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
                    child: AppSearchBar(
                      controller: _searchController,
                      focusNode: _focusNode,
                      autofocus: false,
                      heroTag: widget.heroTag,
                      hintText: 'Destinations, trips, activities...',
                      onChanged: (query) {
                        context.read<GlobalSearchBloc>().add(
                          SearchQueryChanged(query),
                        );
                        setState(() {});
                      },
                      onClear: () {
                        context.read<GlobalSearchBloc>().add(
                          const ClearSearch(),
                        );
                      },
                    ),
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
                                  '${AppRoutes.placeDetails}?placeId=${place.id}&heroTag=rec_${place.id}',
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

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Recent Searches',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TapScaleEffect(
                    onTap: () {
                      context.read<GlobalSearchBloc>().add(
                        const ClearRecentSearches(),
                      );
                    },
                    child: Text(
                      'Clear',
                      style: AppTextStyles.h9SemiBold.copyWith(
                        color: context.colorTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),

                  child: ListView.separated(
                    itemCount: state.recentSearches.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1.h,
                      color: context.colorTheme.outline.withValues(alpha: 0.1),
                    ),
                    itemBuilder: (context, index) {
                      final search = state.recentSearches[index];
                      return TapScaleEffect(
                        onTap: () {
                          _searchController.text = search.query;
                          _searchController
                              .selection = TextSelection.fromPosition(
                            TextPosition(offset: _searchController.text.length),
                          );
                          context.read<GlobalSearchBloc>().add(
                            SearchQueryChanged(search.query),
                          );
                          _focusNode.unfocus();
                        },
                        child: ListTile(
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

                          trailing: Icon(
                            Icons.north_west_rounded,
                            size: 24.sp,
                            color: context.colorTheme.outline.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
