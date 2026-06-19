import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_refresh_indicator.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';
import 'package:mindtrip/features/places/presentation/widgets/recommended_grid.dart';

class RecommendedPlacesScreen extends StatefulWidget {
  const RecommendedPlacesScreen({super.key});

  @override
  State<RecommendedPlacesScreen> createState() =>
      _RecommendedPlacesScreenState();
}

class _RecommendedPlacesScreenState extends State<RecommendedPlacesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final interests = context.read<UserCubit>().state.interests;
    context.read<RecommendedPlacesCubit>().loadFirstPage(
      selectedCategories: interests,
    );
  }

  void _onScroll() {
    if (_isBottom) {
      final interests = context.read<UserCubit>().state.interests;
      context.read<RecommendedPlacesCubit>().loadMorePlaces(
        selectedCategories: interests,
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 450;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: () async {
        await context.read<RecommendedPlacesCubit>().loadFirstPage(
          selectedCategories: context.read<UserCubit>().state.interests,
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: BlocBuilder<RecommendedPlacesCubit, RecommendedPlacesState>(
              builder: (context, state) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              Hero(
                                tag: 'section_Recommended',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'Recommended',
                                    style: context.textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                    _buildGrid(state),
                    if (state.isMoreLoading)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(RecommendedPlacesState state) {
    if (state.recommendedPlacesStatus.isFailure) {
      return SliverToBoxAdapter(
        child: AppErrorWidget(
          message: state.error,
          imageSize: 80,
          onPressed: () {
            final interests = context.read<UserCubit>().state.interests;
            context.read<RecommendedPlacesCubit>().loadFirstPage(
              selectedCategories: interests,
            );
          },
        ),
      );
    }

    final isLoading =
        state.recommendedPlacesStatus.isLoading ||
        state.recommendedPlacesStatus.isInitial;
    final destinations = isLoading ? DummyData.recommendedPlaces : state.places;

    if (!isLoading && destinations.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return RecommendedplacesGrid(
      destinations: destinations,
      isLoading: isLoading,
    );
  }
}
