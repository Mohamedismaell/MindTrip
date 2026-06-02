// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
// import 'package:mindtrip/core/shared/injection/service_locator.dart';
// import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
// import 'package:mindtrip/core/shared/routes/app_routes.dart';
// import 'package:mindtrip/core/theme/app_colors.dart';
// import 'package:mindtrip/core/theme/app_text_styles.dart';
// import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/core/widget/custom_gradient_button.dart';
// import 'package:mindtrip/core/widget/tap_scale_effect.dart';
// import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';

// Future<void> showAddToTripSheet(
//   BuildContext context, {
//   required PlaceEntity place,
// }) async {
//   await showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     useSafeArea: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => BlocProvider(
//       create: (_) => sl<AddToTripCubit>(param1: place)..load(),
//       child: AddToTripSheet(place: place),
//     ),
//   );
// }

// class AddToTripSheet extends StatelessWidget {
//   final PlaceEntity place;

//   const AddToTripSheet({super.key, required this.place});

//   @override
//   Widget build(BuildContext context) {
//     final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

//     return BlocConsumer<AddToTripCubit, AddToTripState>(
//       listenWhen: (previous, current) =>
//           previous.status != current.status ||
//           previous.errorMessage != current.errorMessage,
//       listener: (context, state) {
//         if (state.status == AddToTripStatus.success &&
//             state.successTripId != null) {
//           _showSuccessDialog(context, state);
//         }
//         if (state.status == AddToTripStatus.error &&
//             state.errorMessage != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errorMessage!),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: maxHeight),
//           child: _SheetScaffold(
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 180),
//               child: _buildStep(context, state),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildStep(BuildContext context, AddToTripState state) {
//     if (state.status == AddToTripStatus.loading) {
//       return const _LoadingTripsView(key: ValueKey('loading-trips'));
//     }

//     if (state.status == AddToTripStatus.optimizing) {
//       return _OptimizingView(
//         key: const ValueKey('optimizing'),
//         title:
//             state.selectedOption?.trip.title ??
//             state.successTripTitle ??
//             state.placement?.trip.title ??
//             'your trip',
//       );
//     }

//     return switch (state.step) {
//       AddToTripSheetStep.trips => _TripSelectionView(
//         key: const ValueKey('trips'),
//         place: place,
//         state: state,
//       ),
//       AddToTripSheetStep.days => _DaySelectionView(
//         key: const ValueKey('days'),
//         state: state,
//       ),
//       AddToTripSheetStep.quickPlan => const _QuickPlanView(
//         key: ValueKey('quick-plan'),
//       ),
//       AddToTripSheetStep.manage => _ManageTripView(
//         key: const ValueKey('manage'),
//         state: state,
//       ),
//     };
//   }

//   Future<void> _showSuccessDialog(
//     BuildContext context,
//     AddToTripState state,
//   ) async {
//     await showDialog<void>(
//       context: context,
//       barrierColor: AppColors.pureBlack.withValues(alpha: 0.58),
//       builder: (dialogContext) {
//         return Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 32.w),
//             child: Material(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(28.r),
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 28.h),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Your Trip Has Been Updated !',
//                       textAlign: TextAlign.center,
//                       style: AppTextStyles.h6Bold.copyWith(
//                         color: AppColors.primaryBlue,
//                       ),
//                     ),
//                     SizedBox(height: 28.h),
//                     CustomGradientButton(
//                       width: 210.w,
//                       text: 'View',
//                       style: AppTextStyles.h6Bold.copyWith(
//                         color: AppColors.pureWhite,
//                       ),
//                       onTap: () {
//                         final tripId = state.successTripId;
//                         if (tripId == null) return;
//                         Navigator.of(dialogContext).pop();
//                         Navigator.of(context).pop();
//                         context.go('${AppRoutes.tripDetails}?tripId=$tripId');
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _SheetScaffold extends StatelessWidget {
//   final Widget child;

//   const _SheetScaffold({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: context.colorTheme.surface,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 26.h),
//             const _SheetHandle(),
//             Flexible(child: child),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SheetHandle extends StatelessWidget {
//   const _SheetHandle();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 60.w,
//       height: 5.h,
//       decoration: BoxDecoration(
//         color: context.colorTheme.outline.withValues(alpha: 0.65),
//         borderRadius: BorderRadius.circular(999.r),
//       ),
//     );
//   }
// }

// class _SheetHeader extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool showBack;
//   final VoidCallback? onBack;

//   const _SheetHeader({
//     required this.title,
//     required this.subtitle,
//     this.showBack = false,
//     this.onBack,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 0),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (showBack)
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TapScaleEffect(
//                 onTap: onBack,
//                 child: Icon(
//                   Icons.arrow_back_rounded,
//                   size: 32.r,
//                   color: context.colorTheme.onSurfaceVariant,
//                 ),
//               ),
//             ),
//           Column(
//             children: [
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.h6Bold.copyWith(
//                   color: context.colorTheme.onSurface,
//                   fontSize: 24.sp,
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 subtitle,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.h9Regular.copyWith(
//                   color: context.colorTheme.outline,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TripSelectionView extends StatelessWidget {
//   final PlaceEntity place;
//   final AddToTripState state;

//   const _TripSelectionView({
//     super.key,
//     required this.place,
//     required this.state,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<AddToTripCubit>();
//     final currentTripId = state.placement?.trip.id;
//     final options = currentTripId == null
//         ? state.options
//         : state.options
//               .where((option) => option.trip.id != currentTripId)
//               .toList();
//     final isMoving = currentTripId != null;

//     return ListView(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 28.h),
//       children: [
//         _SheetHeader(
//           title: isMoving ? 'Move to Another Trip' : 'Add to a Trip',
//           subtitle: isMoving
//               ? 'Choose where to move this place'
//               : 'Choose where you want to add this place',
//           showBack: isMoving,
//           onBack: cubit.openManage,
//         ),
//         SizedBox(height: 24.h),
//         if (options.isEmpty)
//           _EmptyTripsCard(onTap: cubit.openQuickPlan)
//         else
//           ...options.map(
//             (option) => Padding(
//               padding: EdgeInsets.only(bottom: 24.h),
//               child: _TripCard(
//                 option: option,
//                 onTap: () {
//                   if (isMoving) {
//                     cubit.moveToAnotherTrip(option);
//                   } else {
//                     cubit.selectTrip(option);
//                   }
//                 },
//               ),
//             ),
//           ),
//         _CreateTripCard(onTap: cubit.openQuickPlan),
//       ],
//     );
//   }
// }

// class _TripCard extends StatelessWidget {
//   final TripOption option;
//   final VoidCallback onTap;

//   const _TripCard({required this.option, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final image =
//         option.trip.itineraryCoverUrl ??
//         option.trip.placePreviews.firstOrNull?['imageUrl'];

//     return _OutlinedActionCard(
//       onTap: onTap,
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4.r),
//             child: AppCachedImage(
//               imagePath: image?.isNotEmpty == true
//                   ? image
//                   : 'assets/images/onboarding/Pyramids.webp',
//               width: 86.w,
//               height: 86.w,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(width: 14.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   option.trip.title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: AppTextStyles.h8SemiBold.copyWith(
//                     color: context.colorTheme.onSurfaceVariant,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   '${option.dayCount} days . ${option.placeCount} places',
//                   style: AppTextStyles.h9Regular.copyWith(
//                     color: context.colorTheme.outline,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(
//             Icons.chevron_right_rounded,
//             size: 28.r,
//             color: context.colorTheme.onSurfaceVariant,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CreateTripCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const _CreateTripCard({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return _OutlinedActionCard(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Container(
//             width: 86.w,
//             height: 86.w,
//             decoration: BoxDecoration(
//               color: context.colorTheme.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(4.r),
//             ),
//             child: Icon(
//               Icons.add_rounded,
//               size: 34.r,
//               color: context.colorTheme.onSurfaceVariant,
//             ),
//           ),
//           SizedBox(width: 14.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Create New Trip',
//                   style: AppTextStyles.h8SemiBold.copyWith(
//                     color: context.colorTheme.onSurfaceVariant,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'Start planning with AI',
//                   style: AppTextStyles.h9Regular.copyWith(
//                     color: context.colorTheme.outline,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(
//             Icons.chevron_right_rounded,
//             size: 28.r,
//             color: context.colorTheme.onSurfaceVariant,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _EmptyTripsCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const _EmptyTripsCard({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 24.h),
//       child: _OutlinedActionCard(
//         onTap: onTap,
//         child: Center(
//           child: Text(
//             'No editable trips yet. Create one to continue.',
//             textAlign: TextAlign.center,
//             style: AppTextStyles.h9Regular.copyWith(
//               color: context.colorTheme.outline,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DaySelectionView extends StatelessWidget {
//   final AddToTripState state;

//   const _DaySelectionView({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<AddToTripCubit>();
//     final option = state.selectedOption;
//     if (option == null) return const SizedBox.shrink();
//     final isMoveWithinCurrentTrip = state.placement?.trip.id == option.trip.id;

//     return ListView(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.fromLTRB(36.w, 0, 36.w, 28.h),
//       children: [
//         _SheetHeader(
//           title: 'Add to ${option.trip.title}',
//           subtitle: 'Choose where to add it',
//           showBack: true,
//           onBack: state.placement == null ? cubit.openTrips : cubit.openManage,
//         ),
//         SizedBox(height: 28.h),
//         ...option.itinerary.days.map(
//           (day) => Padding(
//             padding: EdgeInsets.only(bottom: 24.h),
//             child: _DayCard(
//               day: day,
//               selected: state.placement?.dayNumber == day.dayNumber,
//               onTap: () => isMoveWithinCurrentTrip
//                   ? cubit.moveToDay(day.dayNumber)
//                   : cubit.addToDay(day.dayNumber),
//             ),
//           ),
//         ),
//         _AiDecideCard(onTap: cubit.addWithAi),
//       ],
//     );
//   }
// }

// class _DayCard extends StatelessWidget {
//   final TripDay day;
//   final bool selected;
//   final VoidCallback onTap;

//   const _DayCard({
//     required this.day,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final places = day.timeSlots.expand((slot) => slot.places).toList();
//     final visiblePlaces = places.take(2).map((place) => place.name).join(' - ');
//     final extra = places.length > 2 ? '\n+${places.length - 2} more' : '';

//     return _OutlinedActionCard(
//       onTap: onTap,
//       borderColor: selected ? AppColors.primaryBlue : null,
//       minHeight: 138.h,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.calendar_month_outlined, size: 25.r),
//               SizedBox(width: 18.w),
//               Text(
//                 'Day ${day.dayNumber}',
//                 style: AppTextStyles.h6Bold.copyWith(
//                   color: context.colorTheme.onSurface,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 22.h),
//           Text(
//             places.isEmpty ? 'No places yet' : '$visiblePlaces$extra',
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: AppTextStyles.h8Regular.copyWith(
//               color: context.colorTheme.onSurfaceVariant,
//               height: 1.25,
//             ),
//           ),
//           SizedBox(height: 18.h),
//           Text(
//             'Includes ${places.length} places',
//             style: AppTextStyles.h7Bold.copyWith(
//               color: context.colorTheme.onSurface,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AiDecideCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const _AiDecideCard({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return TapScaleEffect(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(14.r),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//         decoration: BoxDecoration(
//           color: AppColors.primaryLightBlue1,
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(color: context.colorTheme.onSurfaceVariant),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.smart_toy_outlined,
//               size: 42.r,
//               color: context.colorTheme.onSurfaceVariant,
//             ),
//             SizedBox(width: 22.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Let AI Decide',
//                     style: AppTextStyles.h6Bold.copyWith(
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     'Find the best day automatically.',
//                     style: AppTextStyles.h8Regular.copyWith(
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.chevron_right_rounded,
//               size: 36.r,
//               color: context.colorTheme.onSurfaceVariant,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _QuickPlanView extends StatefulWidget {
//   const _QuickPlanView({super.key});

//   @override
//   State<_QuickPlanView> createState() => _QuickPlanViewState();
// }

// class _QuickPlanViewState extends State<_QuickPlanView> {
//   late DateTime _startDate;
//   late DateTime _endDate;
//   QuickTripBudget _budget = QuickTripBudget.economic;
//   int _peopleCount = 5;

//   @override
//   void initState() {
//     super.initState();
//     final now = DateTime.now();
//     _startDate = DateTime(now.year, now.month, now.day + 1);
//     _endDate = _startDate.add(const Duration(days: 6));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.fromLTRB(36.w, 0, 36.w, 30.h),
//       children: [
//         _SheetHeader(
//           title: 'Quick AI Trip Planning',
//           subtitle:
//               'This is a quick overview. For a detailed itinerary, return to the AI trip planner.',
//           showBack: true,
//           onBack: context.read<AddToTripCubit>().openTrips,
//         ),
//         SizedBox(height: 34.h),
//         _FormSection(
//           title: 'Duration',
//           child: Column(
//             children: [
//               _DateField(
//                 label: 'Start date :',
//                 date: _startDate,
//                 onTap: () => _pickDate(isStart: true),
//               ),
//               Divider(height: 28.h, color: context.colorTheme.outline),
//               _DateField(
//                 label: 'End date :',
//                 date: _endDate,
//                 onTap: () => _pickDate(isStart: false),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20.h),
//         _FormSection(
//           title: 'Budget',
//           child: Wrap(
//             spacing: 16.w,
//             runSpacing: 12.h,
//             children: QuickTripBudget.values.map((budget) {
//               final selected = _budget == budget;
//               return ChoiceChip(
//                 selected: selected,
//                 label: Text(_budgetLabel(budget)),
//                 onSelected: (_) => setState(() => _budget = budget),
//                 selectedColor: AppColors.primaryLightBlue1,
//                 backgroundColor: context.colorTheme.surface,
//                 side: BorderSide(color: context.colorTheme.outline),
//                 labelStyle: AppTextStyles.h8Regular.copyWith(
//                   color: selected
//                       ? context.colorTheme.onSurfaceVariant
//                       : context.colorTheme.outline,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: 20.h),
//         _FormSection(
//           title: 'Number of people',
//           child: TextFormField(
//             initialValue: _peopleCount.toString(),
//             keyboardType: TextInputType.number,
//             style: AppTextStyles.h8Regular.copyWith(
//               color: context.colorTheme.onSurfaceVariant,
//             ),
//             decoration: _fieldDecoration(context),
//             onChanged: (value) {
//               _peopleCount = int.tryParse(value) ?? _peopleCount;
//             },
//           ),
//         ),
//         SizedBox(height: 64.h),
//         CustomGradientButton(
//           width: double.infinity,
//           text: 'Generate Plan',
//           style: AppTextStyles.h6Bold.copyWith(color: AppColors.pureWhite),
//           onTap: () => context.read<AddToTripCubit>().createQuickTrip(
//             startDate: _startDate,
//             endDate: _endDate,
//             budget: _budget,
//             peopleCount: _peopleCount.clamp(1, 99),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _pickDate({required bool isStart}) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isStart ? _startDate : _endDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 730)),
//     );
//     if (picked == null) return;
//     setState(() {
//       if (isStart) {
//         _startDate = picked;
//         if (_endDate.isBefore(_startDate)) {
//           _endDate = _startDate.add(const Duration(days: 1));
//         }
//       } else {
//         _endDate = picked.isBefore(_startDate) ? _startDate : picked;
//       }
//     });
//   }

//   String _budgetLabel(QuickTripBudget budget) => switch (budget) {
//     QuickTripBudget.economic => 'Economic',
//     QuickTripBudget.comfortable => 'Comfortable',
//     QuickTripBudget.luxury => 'Luxury',
//   };
// }

// class _FormSection extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const _FormSection({required this.title, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(22.r),
//       decoration: BoxDecoration(
//         color: context.colorTheme.surface,
//         borderRadius: BorderRadius.circular(22.r),
//         border: Border.all(color: context.colorTheme.outline),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppTextStyles.h6Bold.copyWith(
//               color: context.colorTheme.onSurface,
//             ),
//           ),
//           SizedBox(height: 18.h),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime date;
//   final VoidCallback onTap;

//   const _DateField({
//     required this.label,
//     required this.date,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: AppTextStyles.h7Medium.copyWith(
//             color: context.colorTheme.onSurfaceVariant,
//           ),
//         ),
//         SizedBox(height: 12.h),
//         InkWell(
//           borderRadius: BorderRadius.circular(8.r),
//           onTap: onTap,
//           child: InputDecorator(
//             decoration: _fieldDecoration(context),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     _formatDate(date),
//                     style: AppTextStyles.h8Regular.copyWith(
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.calendar_month_rounded,
//                   color: AppColors.primaryBlue,
//                   size: 28.r,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatDate(DateTime date) {
//     final day = date.day.toString().padLeft(2, '0');
//     final month = date.month.toString().padLeft(2, '0');
//     return '$day/$month/${date.year}';
//   }
// }

// InputDecoration _fieldDecoration(BuildContext context) {
//   return InputDecoration(
//     filled: true,
//     fillColor: context.colorTheme.surfaceContainerHighest,
//     isDense: true,
//     contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.r),
//       borderSide: BorderSide.none,
//     ),
//   );
// }

// class _ManageTripView extends StatelessWidget {
//   final AddToTripState state;

//   const _ManageTripView({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final placement = state.placement;
//     if (placement == null) {
//       return const SizedBox.shrink();
//     }
//     final cubit = context.read<AddToTripCubit>();

//     return ListView(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.fromLTRB(28.w, 0, 28.w, 34.h),
//       children: [
//         const _SheetHeader(
//           title: 'Manage Trip',
//           subtitle: 'Update where this place is saved',
//         ),
//         SizedBox(height: 40.h),
//         _ManageAction(
//           number: '1.',
//           title: 'Move to Another Day',
//           subtitle: 'Choose a different day',
//           onTap: () => cubit.selectTrip(
//             TripOption(trip: placement.trip, itinerary: placement.itinerary),
//           ),
//         ),
//         _DividerLine(),
//         _ManageAction(
//           number: '2.',
//           title: 'Move to Another Trip',
//           subtitle: 'Move this destination to another trip',
//           onTap: cubit.openTrips,
//         ),
//         _DividerLine(),
//         _ManageAction(
//           number: '3.',
//           title: 'Remove from Trip',
//           subtitle: 'Remove this destination from your itinerary',
//           danger: true,
//           onTap: cubit.removeFromTrip,
//         ),
//       ],
//     );
//   }
// }

// class _ManageAction extends StatelessWidget {
//   final String number;
//   final String title;
//   final String subtitle;
//   final bool danger;
//   final VoidCallback onTap;

//   const _ManageAction({
//     required this.number,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//     this.danger = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = danger
//         ? AppColors.errorRed
//         : context.colorTheme.onSurfaceVariant;
//     return TapScaleEffect(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 24.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$number $title',
//               style: AppTextStyles.h7Bold.copyWith(color: color),
//             ),
//             SizedBox(height: 16.h),
//             Padding(
//               padding: EdgeInsets.only(left: 28.w),
//               child: Text(
//                 subtitle,
//                 style: AppTextStyles.h8Regular.copyWith(
//                   color: context.colorTheme.onSurfaceVariant,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DividerLine extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Divider(height: 1, color: context.colorTheme.outline);
//   }
// }

// class _OptimizingView extends StatelessWidget {
//   final String title;

//   const _OptimizingView({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(36.w, 0, 36.w, 40.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _SheetHeader(
//             title: 'Add to $title',
//             subtitle: 'Choose where to add it',
//             showBack: true,
//             onBack: () {},
//           ),
//           SizedBox(height: 44.h),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 56.h),
//             decoration: BoxDecoration(
//               color: context.colorTheme.surface,
//               borderRadius: BorderRadius.circular(28.r),
//               border: Border.all(color: context.colorTheme.outline),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: 54.r,
//                   height: 54.r,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 7,
//                     color: AppColors.primaryBlue,
//                     backgroundColor: AppColors.primaryBlue.withValues(
//                       alpha: 0.12,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//                 Text(
//                   'AI optimizing your\nschedule...',
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.h5Bold.copyWith(
//                     color: context.colorTheme.onSurface,
//                     height: 1.18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _LoadingTripsView extends StatelessWidget {
//   const _LoadingTripsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 80.h),
//       child: const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class _OutlinedActionCard extends StatelessWidget {
//   final Widget child;
//   final VoidCallback onTap;
//   final Color? borderColor;
//   final double? minHeight;

//   const _OutlinedActionCard({
//     required this.child,
//     required this.onTap,
//     this.borderColor,
//     this.minHeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TapScaleEffect(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(13.r),
//       child: Container(
//         width: double.infinity,
//         constraints: BoxConstraints(minHeight: minHeight ?? 100.h),
//         padding: EdgeInsets.all(8.r),
//         decoration: BoxDecoration(
//           color: context.colorTheme.surface,
//           borderRadius: BorderRadius.circular(13.r),
//           border: Border.all(color: borderColor ?? context.colorTheme.outline),
//         ),
//         child: child,
//       ),
//     );
//   }
// }
