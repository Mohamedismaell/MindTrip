// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
// import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
// import 'package:mindtrip/core/theme/app_colors.dart';
// import 'package:mindtrip/core/theme/app_text_styles.dart';
// import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
// import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
// import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
// import 'package:mindtrip/features/trips/domain/entities/trip.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class AddToTripSheet extends StatelessWidget {
//   const AddToTripSheet({
//     super.key,
//     this.scrollController,
//     required this.onBack,
//     required this.onCreateNew,
//     required this.onTripSelected,
//   });

//   final ScrollController? scrollController;
//   final VoidCallback onBack;
//   final VoidCallback onCreateNew;
//   final ValueChanged<Trip> onTripSelected;

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
//       },
//       builder: (context, state) {
//         if (state.tripsStatus == TripsLoadStatus.error) {
//           //Todo change the ui
//           return AppErrorWidget(
//             imageSize: MediaQuery.sizeOf(context).width,
//             title: 'Failed to load trips',
//             message:
//                 state.errorMessage ??
//                 'Please check your connection or try again later',
//             // onPressed: () => context.read<AddToTripCubit>().loadTrips(),
//           );
//         }

//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const DragDivider(),
//             SizedBox(height: 25.h),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: state.placeAlreadyInTrip
//                       ? IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: onBack,
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//                 Text(
//                   state.placeAlreadyInTrip
//                       ? 'Move to another Trip'
//                       : 'Add to a Trip',
//                   style: AppTextStyles.h6Bold.copyWith(
//                     color: AppColors.pureBlack,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Choose where you want to add this place',
//               style: context.textTheme.bodyMedium?.copyWith(
//                 color: context.colorTheme.outline,
//               ),
//             ),
//             SizedBox(height: 24.h),
//             Expanded(
//               child: Skeletonizer(
//                 enabled: state.tripsStatus == TripsLoadStatus.loading,
//                 child: ListView.separated(
//                   controller: scrollController,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount:
//                       state.trips.isEmpty &&
//                           state.tripsStatus == TripsLoadStatus.loading
//                       ? 2
//                       : state.trips.length + 1,
//                   separatorBuilder: (_, _) => SizedBox(height: 16.h),
//                   itemBuilder: (context, index) {
//                     if (state.trips.isEmpty &&
//                         state.tripsStatus == TripsLoadStatus.loading) {
//                       return _TripTile(
//                         title: 'Loading Trip Title',
//                         subtitle: 'Loading description...',
//                         onTap: () {},
//                       );
//                     }

//                     if (index == state.trips.length) {
//                       return _TripTile(
//                         title: 'Create New Trip',
//                         subtitle: 'Start planning with AI',
//                         leadingIcon: Icons.add,
//                         onTap: onCreateNew,
//                       );
//                     }
//                     final trip = state.trips[index];
//                     final coverImage = trip.coverImageUrl ?? trip.coverImageUrl;
//                     return _TripTile(
//                       title: trip.title,
//                       subtitle: '${trip.durationDays} days',
//                       imagePath: coverImage,
//                       onTap: () => onTripSelected(trip),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _TripTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String? imagePath;
//   final VoidCallback onTap;
//   final IconData? leadingIcon;

//   const _TripTile({
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//     this.imagePath,
//     this.leadingIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TapScaleEffect(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(8.r),
//         decoration: BoxDecoration(
//           border: Border.all(color: context.colorTheme.outline),
//           borderRadius: BorderRadius.circular(15.r),
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20.r),
//               child: imagePath != null
//                   ? AppCachedImage(
//                       width: 84.w,
//                       height: 84.h,
//                       imagePath: imagePath,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(
//                       width: 84.w,
//                       height: 84.h,
//                       color: AppColors.primaryLightGray,
//                       alignment: Alignment.center,
//                       child: Skeleton.ignore(
//                         child: Icon(
//                           leadingIcon ?? Icons.add,
//                           size: 30.r,
//                           color: context.colorTheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ),
//             ),
//             SizedBox(width: 13.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: AppTextStyles.h8SemiBold.copyWith(
//                       color: context.colorTheme.onSurface,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     subtitle,
//                     style: AppTextStyles.h9Medium.copyWith(
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.chevron_right,
//               size: 24.r,
//               color: context.colorTheme.onSurfaceVariant,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
