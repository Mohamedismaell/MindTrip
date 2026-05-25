import 'dart:convert';
import 'package:hive_ce/hive.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/trip_itinerary_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';

/// Abstract interface. Swap [MockItineraryDataSource] with a real HTTP client when API is ready.
/// The real API contract (request → response) mirrors this interface:
/// - Input: [Trip] (destination, dates, travelers, budget, interests, chat messages)
/// - Output: [TripItineraryModel] (days with morning/afternoon/evening slots and places)
abstract class ItineraryDataSource {
  Future<TripItineraryModel> generate(Trip trip);
  Future<TripItineraryModel?> getByTripId(String tripId);
  Future<void> save(TripItineraryModel itinerary);
}

/// Simulates a backend that accepts trip parameters and returns a full itinerary.
/// Replace this class with an HTTP datasource when the real API is ready.
/// The response structure matches [TripItineraryModel.fromJson].
class MockItineraryDataSource implements ItineraryDataSource {
  /// Persists itineraries as JSON strings keyed by tripId.
  /// Injected from [AppHive.itinerariesBox] so data survives app restarts.
  final Box<String> _box;

  MockItineraryDataSource(this._box);

  @override
  Future<TripItineraryModel> generate(Trip trip) async {
    // Simulate backend network latency (2-3 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // In real API: POST /trips/generate with trip data → response JSON
    // Here: pick a rich mock based on destination
    final dest = trip.destination.toLowerCase();
    final tripId = trip.id;
    final days = trip.durationDays.clamp(1, 5); // cap at 5 days for mock

    if (dest.contains('paris')) return _buildParisItinerary(tripId, days);
    if (dest.contains('rome')) return _buildRomeItinerary(tripId, days);
    if (dest.contains('dahab')) return _buildDahabItinerary(tripId, days);
    if (dest.contains('cairo')) return _buildCairoItinerary(tripId, days);
    return _buildGenericItinerary(tripId, trip.destination, days);
  }

  @override
  Future<TripItineraryModel?> getByTripId(String tripId) async {
    final json = _box.get(tripId);
    if (json == null) return null;
    try {
      return TripItineraryModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(TripItineraryModel itinerary) async {
    await _box.put(itinerary.tripId, jsonEncode(itinerary.toJson()));
  }

  // ──────────────────────────────────────────────────────────────
  // MOCK ITINERARY BUILDERS — simulating real API JSON responses
  // ──────────────────────────────────────────────────────────────

  TripItineraryModel _buildParisItinerary(String tripId, int days) {
    return TripItineraryModel(
      tripId: tripId,
      estimatedTotalCost: 2200.0 * days,
      days: List.generate(days.clamp(1, 3), (i) {
        final dayNum = i + 1;
        return TripDayModel(
          dayNumber: dayNum,
          title: [
            'Eiffel & Montmartre',
            'Louvre & Seine',
            'Versailles Day Trip',
          ][i % 3],
          coverImageUrl:
              'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?w=800',
          tags: [
            ['Art', 'History', 'Romance'],
            ['Museums', 'River', 'Culture'],
            ['Palace', 'Gardens', 'History'],
          ][i % 3],
          stopCount: 3,
          estimatedCost: 2200.0,
          timeSlots: [
            TimeSlotModel(
              period: DayPeriod.morning,
              title: 'Morning Highlights',
              places: [
                _place(
                  id: 'paris-m-$dayNum',
                  name: [
                    'Eiffel Tower',
                    'Louvre Museum',
                    'Palace of Versailles',
                  ][i % 3],
                  description:
                      'Start your morning with an iconic Parisian landmark.',
                  lat: 48.8584,
                  lng: 2.2945,
                  category: PlaceCategory.heritage,
                  rating: 4.8,
                  imageUrl:
                      'https://images.unsplash.com/photo-1543349689-9a4d426bee8e?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.afternoon,
              title: 'Afternoon Exploration',
              places: [
                _place(
                  id: 'paris-a-$dayNum',
                  name: [
                    'Musée d\'Orsay',
                    'Notre Dame',
                    'Champs-Élysées',
                  ][i % 3],
                  description: 'Explore the cultural heart of Paris.',
                  lat: 48.8600,
                  lng: 2.3266,
                  category: PlaceCategory.museum,
                  rating: 4.7,
                  imageUrl:
                      'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.evening,
              title: 'Evening & Dining',
              places: [
                _place(
                  id: 'paris-e-$dayNum',
                  name: [
                    'Le Marais District',
                    'Montmartre',
                    'Latin Quarter',
                  ][i % 3],
                  description: 'Enjoy French cuisine and evening strolls.',
                  lat: 48.8553,
                  lng: 2.3580,
                  category: PlaceCategory.restaurant,
                  rating: 4.6,
                  imageUrl:
                      'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  TripItineraryModel _buildRomeItinerary(String tripId, int days) {
    return TripItineraryModel(
      tripId: tripId,
      estimatedTotalCost: 1800.0 * days,
      days: List.generate(days.clamp(1, 3), (i) {
        final dayNum = i + 1;
        return TripDayModel(
          dayNumber: dayNum,
          title: [
            'Ancient Rome',
            'Vatican & Piazzas',
            'Trastevere & Borghese',
          ][i % 3],
          coverImageUrl:
              'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=800',
          tags: [
            ['History', 'Ruins', 'Architecture'],
            ['Art', 'Faith', 'Piazzas'],
            ['Local', 'Gardens', 'Food'],
          ][i % 3],
          stopCount: 3,
          estimatedCost: 1800.0,
          timeSlots: [
            TimeSlotModel(
              period: DayPeriod.morning,
              title: 'Morning Must-Sees',
              places: [
                _place(
                  id: 'rome-m-$dayNum',
                  name: [
                    'Colosseum',
                    'St. Peter\'s Basilica',
                    'Borghese Gallery',
                  ][i % 3],
                  description: 'An unforgettable Roman morning.',
                  lat: 41.8902,
                  lng: 12.4922,
                  category: PlaceCategory.heritage,
                  rating: 4.9,
                  imageUrl:
                      'https://images.unsplash.com/photo-1546683001-7e42c35fead1?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.afternoon,
              title: 'Afternoon History',
              places: [
                _place(
                  id: 'rome-a-$dayNum',
                  name: [
                    'Roman Forum',
                    'Vatican Museums',
                    'Piazza Navona',
                  ][i % 3],
                  description: 'Dive deep into Rome\'s rich past.',
                  lat: 41.8925,
                  lng: 12.4853,
                  category: PlaceCategory.museum,
                  rating: 4.8,
                  imageUrl:
                      'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.evening,
              title: 'Authentic Roman Evening',
              places: [
                _place(
                  id: 'rome-e-$dayNum',
                  name: [
                    'Trastevere',
                    'Trevi Fountain',
                    'Campo de\' Fiori',
                  ][i % 3],
                  description: 'Toss a coin, savor pasta, absorb the magic.',
                  lat: 41.8901,
                  lng: 12.4696,
                  category: PlaceCategory.restaurant,
                  rating: 4.7,
                  imageUrl:
                      'https://images.unsplash.com/photo-1503764654157-72d979d9af2f?w=400',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  TripItineraryModel _buildDahabItinerary(String tripId, int days) {
    final tripDays = [
      {
        'title': 'Arrival & Lighthouse Walk',
        'tags': ['Relax', 'Beach', 'Cafe'],
        'morning': [
          ['Dahab Lagoon', 28.4889, 34.5155],
          ['Lagona Beach', 28.4872, 34.5148],
          ['Coral Coast', 28.4901, 34.5164],
        ],
        'afternoon': [
          ['Lighthouse Reef', 28.4971, 34.5161],
          ['Bridge Pool', 28.5004, 34.5185],
          ['Dahab Promenade', 28.4966, 34.5179],
        ],
        'evening': [
          ['Ali Baba Restaurant', 28.4967, 34.5158],
          ['Everyday Cafe', 28.4981, 34.5180],
          ['Shark Restaurant', 28.4975, 34.5167],
        ],
      },

      {
        'title': 'Blue Hole Adventure',
        'tags': ['Diving', 'Adventure', 'Sea'],
        'morning': [
          ['Blue Hole', 28.5723, 34.5365],
          ['Blue Hole Canyon', 28.5698, 34.5352],
          ['Bells Dive Site', 28.5782, 34.5399],
        ],
        'afternoon': [
          ['Three Pools', 28.5552, 34.5314],
          ['Ras Abu Galum', 28.6213, 34.5350],
          ['Abu Helal', 28.5611, 34.5328],
        ],
        'evening': [
          ['El Mundo Restaurant', 28.4968, 34.5171],
          ['Ralphs German Bakery', 28.4977, 34.5175],
          ['Red Cat', 28.4959, 34.5162],
        ],
      },

      {
        'title': 'Lagoon & Kitesurfing',
        'tags': ['Surfing', 'Lagoon', 'Adventure'],
        'morning': [
          ['KiteHouse Dahab', 28.4862, 34.5135],
          ['Harry Nass Center', 28.4874, 34.5142],
          ['Lagoon Kite Beach', 28.4856, 34.5129],
        ],
        'afternoon': [
          ['Speedy Beach', 28.4917, 34.5169],
          ['Poseidon Divers', 28.4950, 34.5174],
          ['Octopus World', 28.4932, 34.5161],
        ],
        'evening': [
          ['Yum Yum Restaurant', 28.4960, 34.5168],
          ['Namaste Cafe', 28.4986, 34.5184],
          ['Blue Beach Club', 28.4972, 34.5170],
        ],
      },

      {
        'title': 'Safari & Desert Camp',
        'tags': ['Desert', 'Safari', 'Nature'],
        'morning': [
          ['Wadi Gnai', 28.4508, 34.5007],
          ['Sinai Safari Camp', 28.4584, 34.5060],
          ['Camel Canyon', 28.4620, 34.5035],
        ],
        'afternoon': [
          ['Colored Canyon', 28.8067, 34.4442],
          ['White Canyon', 28.7210, 34.4125],
          ['Desert Fox Camp', 28.4702, 34.5077],
        ],
        'evening': [
          ['Bedouin Moon Hotel', 28.5007, 34.5194],
          ['Tea Garden Cafe', 28.4979, 34.5177],
          ['Desert BBQ Camp', 28.4684, 34.5051],
        ],
      },

      {
        'title': 'Island Boat Trip',
        'tags': ['Boat', 'Snorkeling', 'Sunset'],
        'morning': [
          ['Tiran Island Boat', 28.5025, 34.5205],
          ['Napoleon Reef', 28.5102, 34.5241],
          ['Bannerfish Bay', 28.5140, 34.5263],
        ],
        'afternoon': [
          ['Golden Blocks', 28.5201, 34.5300],
          ['Moray Garden', 28.5185, 34.5282],
          ['Coral Island Stop', 28.5222, 34.5311],
        ],
        'evening': [
          ['Sea Bride Restaurant', 28.4971, 34.5165],
          ['Downtown Cafe', 28.4964, 34.5172],
          ['Sunset Lounge', 28.4980, 34.5189],
        ],
      },
    ];

    return TripItineraryModel(
      tripId: tripId,
      estimatedTotalCost: 1200.0 * days,
      days: List.generate(days.clamp(1, 5), (i) {
        final dayData = tripDays[i];

        return TripDayModel(
          dayNumber: i + 1,
          title: dayData['title'] as String,
          coverImageUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200',
          tags: dayData['tags'] as List<String>,
          stopCount: 9,
          estimatedCost: 1200,
          timeSlots: [
            /// MORNING
            TimeSlotModel(
              period: DayPeriod.morning,
              title: 'Morning Exploration',
              places: (dayData['morning'] as List<List<dynamic>>).map((p) {
                return _place(
                  id: 'dahab-m-${i}-${p[0]}',
                  name: p[0] as String,
                  description: 'A beautiful morning spot in Dahab.',
                  lat: p[1] as double,
                  lng: p[2] as double,
                  category: PlaceCategory.activity,
                  rating: 4.8,
                  imageUrl:
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
                );
              }).toList(),
            ),

            /// AFTERNOON
            TimeSlotModel(
              period: DayPeriod.afternoon,
              title: 'Adventure Time',
              places: (dayData['afternoon'] as List<List<dynamic>>).map((p) {
                return _place(
                  id: 'dahab-a-${i}-${p[0]}',
                  name: p[0] as String,
                  description: 'Afternoon thrills in the Sinai.',
                  lat: p[1] as double,
                  lng: p[2] as double,
                  category: PlaceCategory.activity,
                  rating: 4.7,
                  imageUrl:
                      'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
                );
              }).toList(),
            ),

            /// EVENING
            TimeSlotModel(
              period: DayPeriod.evening,
              title: 'Food & Sunset',
              places: (dayData['evening'] as List<List<dynamic>>).map((p) {
                return _place(
                  id: 'dahab-e-${i}-${p[0]}',
                  name: p[0] as String,
                  description: 'Watch the sunset over the Red Sea.',
                  lat: p[1] as double,
                  lng: p[2] as double,
                  category: PlaceCategory.restaurant,
                  rating: 4.6,
                  imageUrl:
                      'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?w=400',
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }

  TripItineraryModel _buildCairoItinerary(String tripId, int days) {
    return TripItineraryModel(
      tripId: tripId,
      estimatedTotalCost: 1200.0 * days,
      days: List.generate(days.clamp(1, 3), (i) {
        final dayNum = i + 1;
        return TripDayModel(
          dayNumber: dayNum,
          title: [
            'Pyramids & Sphinx',
            'Old Cairo & Khan',
            'Nile & Museums',
          ][i % 3],
          coverImageUrl:
              'https://images.unsplash.com/photo-1539650116574-8efeb43e2750?w=800',
          tags: [
            ['Pyramids', 'History', 'Wonder'],
            ['Bazaar', 'Culture', 'Markets'],
            ['Nile', 'Museums', 'Cruise'],
          ][i % 3],
          stopCount: 3,
          estimatedCost: 1200.0,
          timeSlots: [
            TimeSlotModel(
              period: DayPeriod.morning,
              title: 'Morning Wonders',
              places: [
                _place(
                  id: 'cairo-m-$dayNum',
                  name: [
                    'Giza Pyramids',
                    'Coptic Cairo',
                    'Egyptian Museum',
                  ][i % 3],
                  description: 'Begin your Cairo adventure at its finest.',
                  lat: 29.9773,
                  lng: 31.1325,
                  category: PlaceCategory.heritage,
                  rating: 4.9,
                  imageUrl:
                      'https://images.unsplash.com/photo-1608135227059-9a0a8c5f1a9f?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.afternoon,
              title: 'Afternoon Culture',
              places: [
                _place(
                  id: 'cairo-a-$dayNum',
                  name: [
                    'The Sphinx',
                    'Khan El Khalili Bazaar',
                    'Tahrir Square',
                  ][i % 3],
                  description: 'Explore Cairo\'s cultural and historic depth.',
                  lat: 29.9753,
                  lng: 31.1376,
                  category: PlaceCategory.museum,
                  rating: 4.7,
                  imageUrl:
                      'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.evening,
              title: 'Nile Evenings',
              places: [
                _place(
                  id: 'cairo-e-$dayNum',
                  name: [
                    'Nile Felucca Ride',
                    'Naguib Mahfouz Cafe',
                    'Sound & Light Show',
                  ][i % 3],
                  description: 'End the day along the legendary Nile.',
                  lat: 30.0444,
                  lng: 31.2357,
                  category: PlaceCategory.restaurant,
                  rating: 4.8,
                  imageUrl:
                      'https://images.unsplash.com/photo-1551918120-9739cb430c6d?w=400',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  TripItineraryModel _buildGenericItinerary(
    String tripId,
    String destination,
    int days,
  ) {
    return TripItineraryModel(
      tripId: tripId,
      estimatedTotalCost: 1500.0 * days,
      days: List.generate(days.clamp(1, 3), (i) {
        final dayNum = i + 1;
        return TripDayModel(
          dayNumber: dayNum,
          title: 'Day $dayNum in $destination',
          coverImageUrl:
              'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800',
          tags: const ['Explore', 'Culture', 'Food'],
          stopCount: 3,
          estimatedCost: 1500.0,
          timeSlots: [
            TimeSlotModel(
              period: DayPeriod.morning,
              title: 'City Center',
              places: [
                _place(
                  id: '$tripId-m-$dayNum',
                  name: 'City Center & Main Square',
                  description: 'Start at the beating heart of $destination.',
                  lat: 30.0444,
                  lng: 31.2357,
                  category: PlaceCategory.heritage,
                  rating: 4.5,
                  imageUrl:
                      'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.afternoon,
              title: 'Local Museum',
              places: [
                _place(
                  id: '$tripId-a-$dayNum',
                  name: 'National Museum',
                  description: 'Discover the history and art of $destination.',
                  lat: 30.0478,
                  lng: 31.2336,
                  category: PlaceCategory.museum,
                  rating: 4.4,
                  imageUrl:
                      'https://images.unsplash.com/photo-1554907984-15263bfd63bd?w=400',
                ),
              ],
            ),
            TimeSlotModel(
              period: DayPeriod.evening,
              title: 'Local Cuisine',
              places: [
                _place(
                  id: '$tripId-e-$dayNum',
                  name: 'Old Town Restaurant District',
                  description: 'Sample the authentic local flavors.',
                  lat: 30.0450,
                  lng: 31.2350,
                  category: PlaceCategory.restaurant,
                  rating: 4.6,
                  imageUrl:
                      'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  /// Helper to construct a [PlaceModel].
  PlaceModel _place({
    required String id,
    required String name,
    String? description,
    required double lat,
    required double lng,
    PlaceCategory category = PlaceCategory.other,
    double? rating,
    String? imageUrl,
  }) {
    return PlaceModel(
      id: id,
      name: name,
      description: description,
      location: LocationModel(address: name, latitude: lat, longitude: lng),
      category: category,
      rating: rating,
      imageUrls: imageUrl != null ? [imageUrl] : null,
    );
  }
}
