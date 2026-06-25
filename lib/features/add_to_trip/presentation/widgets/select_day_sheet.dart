// import 'package:flutter/material.dart' hide DayPeriod;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mindtrip/core/theme/app_colors.dart';
// import 'package:mindtrip/core/theme/app_text_styles.dart';
// import 'package:mindtrip/core/utils/app_assets.dart';
// import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
// import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
// import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
// import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
// import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';

// class SelectDaySheet extends StatelessWidget {
//   const SelectDaySheet({
//     super.key,
//     this.scrollController,
//     required this.onBack,
//     required this.onClose,
//   });

//   final ScrollController? scrollController;
//   final VoidCallback onBack;
//   final VoidCallback onClose;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddToTripCubit, AddToTripState>(
//       listener: (context, state) {
//         if (state.itineraryStatus == TripsLoadStatus.loading ||
//             state.addingStatus == ActionStatus.processing ||
//             state.creatingStatus == ActionStatus.processing) {
//           AppDialog.showLoading(
//             context: context,
//             title: state.loadingTitle,
//             description: state.loadingDescription,
//           );
//         } else {
//           AppDialog.hideLoading(context);
//         }
//         if (state.addingStatus == ActionStatus.success) {
//           AppDialog.show(
//             context: context,
//             title: 'Your Trip Has Been Updated !',
//             //Todo navigate into the trip details screen
//             titleStyle: context.textTheme.headlineSmall?.copyWith(
//               color: context.colorTheme.primary,
//             ),
//             icon: Icons.check_circle_outline_outlined,
//             primaryText: 'Continue Exploring',
//             onPrimary: () {
//               // context.read<AddToTripCubit>().reset();
//               onClose();
//             },
//           );
//         }
//         if (state.addingStatus == ActionStatus.error) {
//           AppGlassSnackBar.showError(
//             context: context,
//             message: state.errorMessage ?? 'Failed to add to trip',
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state.selectedTrip == null || state.selectedItinerary == null) {
//           return const SizedBox.shrink();
//         }

//         final tripTitle = state.selectedTrip!.title;
//         final itinerary = state.selectedItinerary!;

//         return Column(
//           children: [
//             const DragDivider(),
//             SizedBox(height: 16.h),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: onBack,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 48.w),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Add to $tripTitle',
//                         textAlign: TextAlign.center,
//                         style: AppTextStyles.h6Bold.copyWith(
//                           color: context.colorTheme.onSurface,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         'Choose where to add it',
//                         textAlign: TextAlign.center,
//                         style: context.textTheme.bodyMedium?.copyWith(
//                           color: context.colorTheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30.h),
//             Expanded(
//               child: ListView.builder(
//                 controller: scrollController,
//                 itemCount: itinerary.days.length,
//                 itemBuilder: (context, index) {
//                   final day = itinerary.days[index];
//                   final places = day.timeSlots
//                       .expand((slot) => slot.places)
//                       .toList();
//                   final isDaySelected =
//                       day.dayNumber == state.selectedDay &&
//                       state.selectedPeriod != null;
//                   return Container(
//                     margin: EdgeInsets.only(bottom: 24.h),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 5.w,
//                       vertical: 10.h,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isDaySelected
//                             ? context.colorTheme.primary
//                             : context.colorTheme.outline,
//                         width: isDaySelected ? 1.5 : 1,
//                       ),
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.calendar_today,
//                               size: 20.r,
//                               color: AppColors.pureBlack,
//                             ),
//                             SizedBox(width: 12.w),
//                             Text(
//                               'Day ${day.dayNumber}',
//                               style: context.textTheme.bodyLarge,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16.h),
//                         Row(
//                           children: PlaceDayPeriod.values.map((period) {
//                             final isSelected =
//                                 state.selectedDay == day.dayNumber &&
//                                 state.selectedPeriod == period;
//                             return Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                                 child: TapScaleEffect(
//                                   onTap: () {},
//                                   // context
//                                   //     .read<AddToTripCubit>()
//                                   //     .selectPeriod(day.dayNumber, period),
//                                   child: AnimatedContainer(
//                                     duration: const Duration(microseconds: 250),
//                                     curve: Curves.easeInOutCubic,
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 10.w,
//                                       vertical: 2.h,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: isSelected
//                                           ? context.colorTheme.primary
//                                           : context.colorTheme.surface,
//                                       border: Border.all(
//                                         color: isSelected
//                                             ? context.colorTheme.primary
//                                             : context.colorTheme.outline,
//                                       ),
//                                       borderRadius: BorderRadius.circular(8.r),
//                                     ),
//                                     child: Text(
//                                       period.name.capitalize(),
//                                       textAlign: TextAlign.center,
//                                       style: AppTextStyles.h9SemiBold.copyWith(
//                                         color: isSelected
//                                             ? Colors.white
//                                             : context.colorTheme.onSurface,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                         if (places.isNotEmpty) ...[
//                           SizedBox(height: 16.h),
//                           ...places
//                               .take(2)
//                               .map(
//                                 (place) => Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 8.w,
//                                     vertical: 2.h,
//                                   ),
//                                   child: Text(
//                                     "• ${place.name}",
//                                     style: context.textTheme.bodySmall
//                                         ?.copyWith(
//                                           color: context
//                                               .colorTheme
//                                               .onSurfaceVariant,
//                                         ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                           if (places.length > 2)
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8.w,
//                                 vertical: 2.h,
//                               ),
//                               child: Text(
//                                 '+${places.length - 2} more places',
//                                 style: context.textTheme.bodySmall?.copyWith(
//                                   color: context.colorTheme.outline,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                             ),
//                           SizedBox(height: 12.h),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8.w,
//                               vertical: 2.h,
//                             ),
//                             child: Text(
//                               'Includes ${day.stopCount} places',
//                               style: context.textTheme.labelSmall?.copyWith(
//                                 color: context.colorTheme.outline,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 16.h),
//             TapScaleEffect(
//               onTap: () {
//                 // Let AI decide
//                 // context.read<AddToTripCubit>().addToTrip();
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(15.r),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryLightBlue1,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       AiPlannerAssets.chatFaceIcon,
//                       width: 42.w,
//                       height: 42.h,
//                       colorFilter: const ColorFilter.mode(
//                         AppColors.pureBlack,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: 25.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Let AI Decide', style: AppTextStyles.h8Bold),
//                           SizedBox(height: 7.h),
//                           Text(
//                             'Find the best day automatically',
//                             style: context.textTheme.bodySmall?.copyWith(
//                               color: AppColors.pureBlack,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       size: 24.r,
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 16.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.w),
//               child: CustomGradientButton(
//                 width: double.infinity,
//                 text: state.placeAlreadyInTrip ? 'Move' : 'Add',
//                 onTap: state.placeAlreadyInTrip
//                     ? () {
//                         final isDifferentTrip =
//                             state.selectedTrip?.id != state.hostTripId;
//                         if (isDifferentTrip) {
//                           // context.read<AddToTripCubit>().moveToAnotherTrip(
//                           //   state.selectedTrip!,
//                           //   state.selectedDay!,
//                           //   state.selectedPeriod!,
//                           // );
//                         } else {
//                           // context.read<AddToTripCubit>().moveToDay(
//                           //   toDayNumber: state.selectedDay!,
//                           //   toPeriod: state.selectedPeriod!,
//                           // );
//                         }
//                       }
//                     : (state.selectedDay != null &&
//                           state.selectedPeriod != null)
//                     ? () {
//                         // context.read<AddToTripCubit>().addToTrip();
//                       }
//                     : null,
//               ),
//             ),
//             SizedBox(height: 24.h),
//           ],
//         );
//       },
//     );
//   }
// }
