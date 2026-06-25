// import 'dart:typed_data';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
// import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
// import 'package:mindtrip/features/trips/presentation/share_trip/trp_share_state.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:mindtrip/core/utils/screenshot_utils.dart';
// import 'package:mindtrip/features/trips/domain/entities/trip.dart';
// import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_share_card.dart';

// class TripShareCubit extends SafeCubit<TripShareState> {
//   TripShareCubit() : super(TripShareInitial());

//   Future<void> shareTrip({
//     required BuildContext context,
//     required Trip trip,
//     required TripItinerary? itinerary,
//     Rect? sharePositionOrigin,
//   }) async {
//     emitSafe(TripShareLoading());

//     try {
//       // Pre cache the image
//       if (trip.coverImageUrl != null &&
//           trip.coverImageUrl!.startsWith('http')) {
//         try {
//           await precacheImage(
//             CachedNetworkImageProvider(
//               trip.coverImageUrl!,
//               cacheManager: AppCacheManager.instance,
//             ),
//             context,
//           );
//         } catch (e) {
//           debugPrint('Pre-caching failed: $e');
//         }
//       }
//       if (!context.mounted) return;
//       // Capture
//       final Uint8List? imageBytes = await ScreenshotUtils.captureWidget(
//         context: context,
//         widget: TripShareCard(trip: trip, itinerary: itinerary),
//       );

//       // final text =
//       //     "Check out my upcoming trip to ${trip.destination}! 🌍\n\nhttps://mindtrip.app/trips/${trip.id}";

//       final text = "Check out my trip to ${trip.destination}! ✈️";

//       if (imageBytes != null && imageBytes.isNotEmpty) {
//         final xFile = XFile.fromData(
//           imageBytes,
//           mimeType: 'image/png',
//           name: 'trip_snapshot.png',
//         );

//         await SharePlus.instance.share(
//           ShareParams(
//             text: text,
//             files: [xFile],
//             sharePositionOrigin: sharePositionOrigin,
//           ),
//         );
//       } else {
//         // Fallback to text only if image capture fails
//         await SharePlus.instance.share(
//           ShareParams(text: text, sharePositionOrigin: sharePositionOrigin),
//         );
//       }

//       emitSafe(TripShareSuccess());
//     } catch (e) {
//       emitSafe(TripShareError(e.toString()));
//     }
//   }
// }
