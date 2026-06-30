// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
// import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';
// import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_cubit.dart';
// import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_state.dart';
// import 'package:mindtrip/core/shared/routes/app_routes.dart';
// import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/features/profile/presentation/widgets/profile/favorite_trip_card.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class HomeFavoriteTripsSection extends StatelessWidget {
//   const HomeFavoriteTripsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TripFavoriteCubit, TripFavoriteState>(
//       builder: (context, state) {
//         final isLoading = state.status == FavoritesStatus.loading;
//         final trips = state.favoriteTrips;

//         if (!isLoading && trips.isEmpty) {
//           return const SliverToBoxAdapter(child: SizedBox.shrink());
//         }

//         return SliverToBoxAdapter(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: 10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Saved Trips', style: context.textTheme.headlineSmall),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'Your favorite itineraries',
//                       style: context.textTheme.bodyMedium!.copyWith(
//                         color: context.colorTheme.outline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Skeletonizer(
//                 enabled: isLoading,
//                 child: SizedBox(
//                   height: 233.h,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     clipBehavior: Clip.none,
//                     itemCount: isLoading ? 3 : trips.length,
//                     separatorBuilder: (_, _) => SizedBox(width: 24.w),
//                     itemBuilder: (context, index) {
//                       if (isLoading) {
//                         return FavoriteTripCard(trip: _skeletonTrip(index));
//                       }

//                       final trip = trips[index];
//                       return FavoriteTripCard(
//                         trip: trip,
//                         onTap: () {
//                           context.push(
//                             '${AppRoutes.tripDetails}?tripId=${trip.tripId}',
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 28.h),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   FavoriteTripEntity _skeletonTrip(int index) {
//     final now = DateTime.now();
//     return FavoriteTripEntity(
//       favoriteTripId: 'favorite-trip-$index',
//       tripId: 'trip-$index',
//       destination: 'Port Said',
//       startDate: now,
//       endDate: now.add(const Duration(days: 2)),
//       durationDays: 2,
//       status: 'Draft',
//       createdAt: now,
//     );
//   }
// }
