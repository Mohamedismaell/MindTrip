import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/selection_tile.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/tsep_heading.dart';

class DestinationStep extends StatelessWidget {
  const DestinationStep({
    super.key,
    required this.controller,
    // required this.onChanged,
    required this.onDestinationTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onDestinationTap;

  @override
  Widget build(BuildContext context) {
    print('DestinationStep built');
    final canContinue = context.select(
      (AiPlannerCubit bloc) => bloc.state.canContinue,
    );
    final cubit = context.read<AiPlannerCubit>();
    return ListView(
      children: [
        StepHeading(
          title: 'Where do you want to go?',
          subtitle:
              'Pick a destination or type your dream place or chat with AI.',
          icon: Icons.location_on_rounded,
        ),
        SizedBox(height: 24.h),

        _SearchBar(
          controller: controller,
          onChanged: cubit.updateDestinationQuery,
        ),
        SizedBox(height: 37.h),
        _DestinationsList(
          onDestinationTap: onDestinationTap,
          // selectedDestination: state.selectedDestination,
        ),
        SizedBox(height: 32.h),
        FlowButton(
          enabled: canContinue,
          text: 'Continue',
          onTap: cubit.nextPage,
        ),
        SizedBox(height: 24.h),
        AiHint(message: 'Tap the bot if you need some inspiration.'),
      ],
    );
  }
}

class _DestinationsList extends StatefulWidget {
  const _DestinationsList({
    // String? selectedDestination,
    required ValueChanged<String> onDestinationTap,
  }) : // _selectedDestination = selectedDestination,
       _onDestinationTap = onDestinationTap;

  // final List<String> _destinations;
  // final String? _selectedDestination;
  final ValueChanged<String> _onDestinationTap;
  @override
  State<_DestinationsList> createState() => _DestinationsListState();
}

class _DestinationsListState extends State<_DestinationsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_DestinationsList built');
    final cubit = context.read<AiPlannerCubit>();
    return SizedBox(
      height: 201.h,
      child: cubit.getFilteredDestinations(cubit.state.destinationQuery).isEmpty
          ? Center(
              child: Text(
                'No destinations match your search yet.',
                style: AppTextStyles.h9Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            )
          : Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 2.w,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                controller: _scrollController,
                itemCount: cubit
                    .getFilteredDestinations(cubit.state.destinationQuery)
                    .length,
                itemBuilder: (context, index) {
                  final destination = cubit.getFilteredDestinations(
                    cubit.state.destinationQuery,
                  )[index];
                  return SelectionTile(
                    label: destination,
                    selected: cubit.state.selectedDestination == destination,
                    onTap: () => widget._onDestinationTap(destination),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(height: 18.h),
              ),
            ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _requestFocus() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _requestFocus,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.primaryLightGray,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20.sp,
                color: context.colorTheme.outline,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  style: AppTextStyles.h10Regular.copyWith(
                    color: context.colorTheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: 'Destinations, trips, activities...',
                    hintStyle: AppTextStyles.h10Regular.copyWith(
                      color: context.colorTheme.outline,
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
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
