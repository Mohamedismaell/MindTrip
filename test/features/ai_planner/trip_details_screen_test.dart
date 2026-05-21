import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/theme_data_/light_theme_data.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/trip_details_screen.dart';

void main() {
  group('TripDetailsScreen', () {
    testWidgets('renders the Figma overview sections', (tester) async {
      final repo = _FakeTripRepository();

      await _pumpTripDetails(tester, repo);

      expect(find.text('Trip Details'), findsNothing);
      expect(find.text('Day 1'), findsOneWidget);
      expect(find.text('Edit with AI'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Your Trip Map'), 250);
      expect(find.text('Your Trip Map'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Save Trip'), 250);
      expect(find.byKey(const Key('trip-estimate-note')), findsOneWidget);
      expect(find.text('Save Trip'), findsOneWidget);
    });

    testWidgets('expands another day from the View button', (tester) async {
      final repo = _FakeTripRepository();

      await _pumpTripDetails(tester, repo);

      await _dragTripList(tester, -520);
      await tester.tap(find.byKey(const Key('trip-day-2-view-button')));
      await tester.pumpAndSettle();

      expect(find.text('Afternoon - Desert Ride'), findsOneWidget);
      expect(find.text('View less'), findsOneWidget);
    });

    testWidgets('opens map route with all itinerary places', (tester) async {
      final repo = _FakeTripRepository();

      await _pumpTripDetails(tester, repo);

      await _dragTripList(tester, -900);
      await tester.tap(find.byKey(const Key('trip-map-button')));
      await tester.pumpAndSettle();

      expect(find.text('Map places: 6'), findsOneWidget);
    });

    testWidgets('save trip completes an in-progress trip', (tester) async {
      final repo = _FakeTripRepository();

      await _pumpTripDetails(tester, repo);

      await _dragTripList(tester, -1200);
      await tester.tap(find.byKey(const Key('save-trip-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(repo.trip.status, TripStatus.completed);
      expect(find.text('Trip Saved'), findsOneWidget);
    });

    testWidgets('renders missing trip state', (tester) async {
      final repo = _FakeTripRepository(missingTrip: true);

      await _pumpTripDetails(tester, repo);

      expect(find.text('Trip not found'), findsOneWidget);
    });

    testWidgets('renders error state', (tester) async {
      final repo = _FakeTripRepository(throwOnLoad: true);

      await _pumpTripDetails(tester, repo);

      expect(
        find.textContaining('Failed to load trip details'),
        findsOneWidget,
      );
    });
  });
}

Future<void> _dragTripList(WidgetTester tester, double dy) async {
  await tester.drag(find.byType(ListView), Offset(0, dy));
  await tester.pumpAndSettle();
}

Future<void> _pumpTripDetails(
  WidgetTester tester,
  _FakeTripRepository repo,
) async {
  tester.view.physicalSize = const Size(393, 852);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final tripsCubit = TripsCubit(repo);
  await tripsCubit.loadTrips();

  final router = GoRouter(
    initialLocation: '${AppRoutes.tripDetails}?tripId=${repo.trip.id}',
    routes: [
      GoRoute(
        path: AppRoutes.myTrips,
        builder: (context, state) => const Scaffold(body: Text('My Trips')),
      ),
      GoRoute(
        path: AppRoutes.tripDetails,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => TripDetailsCubit(repo)),
            BlocProvider.value(value: tripsCubit),
          ],
          child: TripDetailsScreen(tripId: repo.trip.id),
        ),
      ),
      GoRoute(
        path: AppRoutes.map,
        builder: (_, state) {
          final places = state.extra as List<PlaceModel>? ?? const [];
          return Scaffold(body: Text('Map places: ${places.length}'));
        },
      ),
    ],
  );

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp.router(theme: getLightTheme(), routerConfig: router);
      },
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeTripRepository implements TripRepository {
  _FakeTripRepository({this.missingTrip = false, this.throwOnLoad = false});

  final bool missingTrip;
  final bool throwOnLoad;

  late Trip trip = Trip(
    id: 'trip-1',
    title: 'Trip to Dahab',
    status: TripStatus.inProgress,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
    destination: 'Dahab',
    tripStart: DateTime(2026, 6),
    tripEnd: DateTime(2026, 6, 2),
    adults: 2,
    children: 0,
    pets: 0,
    budgetTier: 'Flexible',
    customBudget: '',
    interests: const ['Beach', 'Adventure'],
    currentPage: 5,
    chatMessages: const [],
  );

  late final TripItinerary itinerary = TripItinerary(
    tripId: trip.id,
    estimatedTotalCost: 1900,
    days: [
      TripDay(
        dayNumber: 1,
        title: 'Arrival & Chill in Dahab',
        coverImageUrl: '',
        tags: const ['Relax', 'Beach', 'Sunset'],
        stopCount: 3,
        estimatedCost: 900,
        timeSlots: [
          _slot(DayPeriod.morning, 'Arrival & Check-in', ['Check in']),
          _slot(DayPeriod.afternoon, 'Beach Time', ['Beach time']),
          _slot(DayPeriod.evening, 'Sunset & Vibes', ['Dinner']),
        ],
      ),
      TripDay(
        dayNumber: 2,
        title: 'Desert Vibes & Local Life',
        coverImageUrl: '',
        tags: const ['Culture', 'Local', 'Relax'],
        stopCount: 3,
        estimatedCost: 1000,
        timeSlots: [
          _slot(DayPeriod.morning, 'Market Walk', ['Old market']),
          _slot(DayPeriod.afternoon, 'Desert Ride', ['Wadi Gnai']),
          _slot(DayPeriod.evening, 'Local Dinner', ['Everyday Cafe']),
        ],
      ),
    ],
  );

  static TimeSlot _slot(DayPeriod period, String title, List<String> names) {
    return TimeSlot(
      period: period,
      title: title,
      places: [
        for (final name in names)
          PlaceModel(
            id: name,
            name: name,
            location: const LocationModel(
              address: 'Dahab',
              latitude: 28.5,
              longitude: 34.5,
            ),
            category: PlaceCategory.activity,
          ),
      ],
    );
  }

  @override
  Future<void> deleteTrip(String id) async {}

  @override
  Future<TripItinerary> generateItinerary(Trip trip) async => itinerary;

  @override
  Future<List<Trip>> getAllTrips() async => missingTrip ? [] : [trip];

  @override
  Future<TripItinerary?> getItinerary(String tripId) async {
    if (throwOnLoad) throw Exception('boom');
    return missingTrip ? null : itinerary;
  }

  @override
  Future<Trip?> getTripById(String id) async {
    if (throwOnLoad) throw Exception('boom');
    return missingTrip ? null : trip;
  }

  @override
  Future<void> saveItinerary(TripItinerary itinerary) async {}

  @override
  Future<void> saveTrip(Trip trip) async {
    this.trip = trip;
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    this.trip = trip;
  }
}
