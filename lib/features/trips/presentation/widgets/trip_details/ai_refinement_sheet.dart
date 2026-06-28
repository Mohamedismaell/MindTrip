import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_message_bubble.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_suggestion_chips.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_typing_indicator.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/ai_edit_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/ai_edit_state.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';

class AiRefinementSheet extends StatefulWidget {
  final Trip trip;
  final TripDetailsCubit tripDetailsCubit;

  const AiRefinementSheet({
    super.key,
    required this.trip,
    required this.tripDetailsCubit,
  });

  static Future<void> show(BuildContext context, Trip trip) {
    final tripDetailsCubit = context.read<TripDetailsCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => sl<AiEditCubit>(param1: trip, param2: trip.plan),
        child: AiRefinementSheet(
          trip: trip,
          tripDetailsCubit: tripDetailsCubit,
        ),
      ),
    ).then((_) {
      // Optional: refresh if needed, but the cubit update handle it
    });
  }

  @override
  State<AiRefinementSheet> createState() => _AiRefinementSheetState();
}

class _AiRefinementSheetState extends State<AiRefinementSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colorTheme.outline.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  width: 44,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colorTheme.primary),
                  ),
                  child: SvgPicture.asset(
                    AiPlannerAssets.chatFaceIcon,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 12.w),
                Text('Edit with Mindy', style: AppTextStyles.h7Bold),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Chat Area
          Expanded(
            child: BlocConsumer<AiEditCubit, AiEditState>(
              listener: (context, state) {
                if (state.messages.isNotEmpty) _scrollToBottom();
                if (state.status == AiEditStatus.success &&
                    state.currentPlan != null &&
                    state.currentPlan!.daysCount > 0) {
                  widget.tripDetailsCubit.updatePlan(state.currentPlan!);
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(20.r),
                  itemCount:
                      state.messages.length +
                      (state.status == AiEditStatus.loading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.messages.length) {
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: ChatTypingIndicator(),
                      );
                    }
                    final message = state.messages[index];
                    return ChatMessageBubble(message: message);
                  },
                );
              },
            ),
          ),

          // Suggestions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: ChatSuggestionChips(
              suggestions: [
                '🏰 More museums',
                '🍝 Local food',
                '💰 Cheaper options',
              ],
              onTap: (value) => _controller.text = value,
            ),
            // Row(
            //   children: [

            //     _SuggestionChip(
            //       label: '💰 Cheaper options',
            //       onTap: () => _controller.text =
            //           'Make the itinerary more budget-friendly.',
            //     ),
            //   ],
            // ),
          ),

          // Input Area
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask Mindy to change anything...',
                      filled: true,
                      fillColor: context.colorTheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                    ),
                    onSubmitted: (val) => _sendMessage(context),
                  ),
                ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  backgroundColor: context.colorTheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () => _sendMessage(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<AiEditCubit>().sendMessage(text);
    _controller.clear();
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ActionChip(
        label: Text(label, style: AppTextStyles.h10SemiBold),
        onPressed: onTap,
        backgroundColor: context.colorTheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
