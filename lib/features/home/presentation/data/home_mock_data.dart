import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

//!Dummy data for the home screen **Not working right now**
class HomeMockData {
  const HomeMockData._();

  static const categories = [
    PlaceCategory.heritage,
    PlaceCategory.camping,
    PlaceCategory.beach,
    PlaceCategory.wellness,
    PlaceCategory.diving,
  ];

  static const banners = [
    BannerEntity(
      id: 'b1',
      title: 'Dive Into the Red Sea',
      imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
    ),
    BannerEntity(
      id: 'b2',
      title: 'Discover Egypt\'s Hidden Wonders',
      imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
    ),
    BannerEntity(
      id: 'b3',
      title: 'Journey Through Ancient History',
      imageUrl: 'https://images.unsplash.com/photo-1568322445389-f64ac2515020',
    ),
  ];

  static const recommendedDestinations = [
    PlaceEntity(
      id: 'p4',
      name: 'Fjord Bay',
      description:
          'A breathtaking coastal bay near Taba famous for its turquoise waters, snorkeling spots, and dramatic mountain backdrop.',
      location: LocationEntity(
        address: 'Taba',
        latitude: 29.4884,
        longitude: 34.8969,
      ),
      price: 150,
      rating: 4.8,
      reviewCount: 2432,
      category: PlaceCategory.beach,
      imageUrls: [
        'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      ],
    ),

    PlaceEntity(
      id: 'p5',
      name: 'Wadi El Rayan',
      description:
          'A protected natural reserve known for Egypt’s largest waterfalls, sand dunes, wildlife, and adventure activities.',
      location: LocationEntity(
        address: 'Fayoum',
        latitude: 29.2089,
        longitude: 30.4474,
      ),
      price: 130,
      rating: 4.7,
      reviewCount: 4152,
      category: PlaceCategory.park,
      imageUrls: [
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
        'https://images.unsplash.com/photo-1441974231531-c6227db76b6e',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      ],
    ),

    PlaceEntity(
      id: 'p6',
      name: 'Ras Mohamed National Park',
      description:
          'One of the world’s top diving destinations featuring vibrant coral reefs, crystal-clear waters, and abundant marine lifeOne of the world’s top diving destinations featuring vibrant coral reefs, crystal-clear waters, and abundant marine lifeOne of the world’s top diving destinations featuring vibrant coral reefs, crystal-clear waters, and abundant marine lifeOne of the world’s top diving destinations featuring vibrant coral reefs, crystal-clear waters, and abundant marine lifeOne of the world’s top diving destinations featuring vibrant coral reefs, crystal-clear waters, and abundant marine life.',
      location: LocationEntity(
        address: 'Sharm El Sheikh',
        latitude: 27.7276,
        longitude: 34.2583,
      ),
      price: 180,
      rating: 4.9,
      reviewCount: 9321,
      category: PlaceCategory.diving,
      imageUrls: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
        'https://images.unsplash.com/photo-1582967788606-a171c1080cb0',
        'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      ],
    ),

    PlaceEntity(
      id: 'p7',
      name: 'Qaitbay Citadel',
      description:
          'A magnificent 15th-century fortress overlooking the Mediterranean, built on the site of the ancient Lighthouse of Alexandria.',
      location: LocationEntity(
        address: 'Alexandria',
        latitude: 31.2135,
        longitude: 29.8853,
      ),
      price: 90,
      rating: 4.7,
      reviewCount: 5180,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1539768942893-daf53e448371',
        'https://images.unsplash.com/photo-1568322445389-f64ac2515020',
        'https://images.unsplash.com/photo-1572252009286-268acec5ca0a',
      ],
    ),

    PlaceEntity(
      id: 'p8',
      name: 'Mount Sinai',
      description:
          'A legendary mountain offering one of Egypt’s most memorable sunrise hikes with spectacular panoramic views.',
      location: LocationEntity(
        address: 'St. Catherine',
        latitude: 28.5394,
        longitude: 33.9750,
      ),
      price: 160,
      rating: 4.8,
      reviewCount: 6825,
      category: PlaceCategory.mountain,
      imageUrls: [
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b',
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      ],
    ),

    PlaceEntity(
      id: 'p9',
      name: 'Cleopatra\'s Pool',
      description:
          'A natural spring in Siwa Oasis known for its refreshing mineral-rich waters surrounded by palm trees.',
      location: LocationEntity(
        address: 'Siwa',
        latitude: 29.2041,
        longitude: 25.5195,
      ),
      price: 80,
      rating: 4.6,
      reviewCount: 2974,
      category: PlaceCategory.wellness,
      imageUrls: [
        'https://images.unsplash.com/photo-1519046904884-53103b34b206',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
      ],
    ),

    PlaceEntity(
      id: 'p10',
      name: 'Khan El Khalili',
      description:
          'Cairo’s historic bazaar packed with traditional crafts, spices, jewelry, cafés, and authentic Egyptian culture.',
      location: LocationEntity(
        address: 'Cairo',
        latitude: 30.0478,
        longitude: 31.2625,
      ),
      price: 50,
      rating: 4.6,
      reviewCount: 11354,
      category: PlaceCategory.shopping,
      imageUrls: [
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        'https://images.unsplash.com/photo-1572252009286-268acec5ca0a',
        'https://images.unsplash.com/photo-1568322445389-f64ac2515020',
      ],
    ),

    PlaceEntity(
      id: 'p11',
      name: 'Wadi El Gemal National Park',
      description:
          'A pristine national park combining untouched beaches, coral reefs, desert landscapes, and rich biodiversity.',
      location: LocationEntity(
        address: 'Marsa Alam',
        latitude: 24.6742,
        longitude: 35.0845,
      ),
      price: 210,
      rating: 4.8,
      reviewCount: 1920,
      category: PlaceCategory.beach,
      imageUrls: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
        'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      ],
    ),
  ];

  static const popularDestinations = [
    PlaceEntity(
      id: 'p1',
      name: 'The Blue Hole',
      description:
          'One of the world’s most famous diving sites, known for its deep blue waters, coral reefs, and incredible underwater visibility.',
      location: LocationEntity(
        address: 'Dahab',
        latitude: 28.5729,
        longitude: 34.5373,
      ),
      category: PlaceCategory.diving,
      rating: 4.9,
      reviewCount: 12458,
      price: 220,
      imageUrls: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
        'https://images.unsplash.com/photo-1582967788606-a171c1080cb0',
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19',
      ],
    ),

    PlaceEntity(
      id: 'p2',
      name: 'White Desert',
      description:
          'A surreal desert landscape filled with unique white chalk rock formations, perfect for camping and stargazing.',
      location: LocationEntity(
        address: 'Farafra',
        latitude: 27.0568,
        longitude: 27.9698,
      ),
      category: PlaceCategory.desert,
      rating: 4.8,
      reviewCount: 5421,
      price: 180,
      imageUrls: [
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
        'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      ],
    ),

    PlaceEntity(
      id: 'p3',
      name: 'Siwa Salt Lakes',
      description:
          'Crystal-clear turquoise lakes where visitors float effortlessly while enjoying the tranquility of Siwa Oasis.',
      location: LocationEntity(
        address: 'Siwa',
        latitude: 29.2032,
        longitude: 25.5197,
      ),
      category: PlaceCategory.wellness,
      rating: 4.7,
      reviewCount: 3894,
      price: 120,
      imageUrls: [
        'https://images.unsplash.com/photo-1519046904884-53103b34b206',
        'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      ],
    ),
  ];
  static const tourPackages = [
    TourPackageEntity(
      id: 'pkg1',
      title: 'Magic Lake Escape',
      location: LocationEntity(
        address: 'Fayoum',
        latitude: 29.2089,
        longitude: 30.4474,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      price: 399,
      rating: 4.8,
      durationDays: 3,
    ),

    TourPackageEntity(
      id: 'pkg2',
      title: 'White Desert Adventure',
      location: LocationEntity(
        address: 'Farafra',
        latitude: 27.0568,
        longitude: 27.9698,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
      price: 459,
      rating: 4.9,
      durationDays: 2,
    ),

    TourPackageEntity(
      id: 'pkg3',
      title: 'Aswan & Nubian Experience',
      location: LocationEntity(
        address: 'Aswan',
        latitude: 24.0889,
        longitude: 32.8998,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b',
      price: 599,
      rating: 4.8,
      durationDays: 4,
    ),

    TourPackageEntity(
      id: 'pkg4',
      title: 'Red Sea Diving Expedition',
      location: LocationEntity(
        address: 'Sharm El Sheikh',
        latitude: 27.9158,
        longitude: 34.3299,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
      price: 649,
      rating: 4.9,
      durationDays: 5,
    ),

    TourPackageEntity(
      id: 'pkg5',
      title: 'Siwa Wellness Retreat',
      location: LocationEntity(
        address: 'Siwa',
        latitude: 29.2032,
        longitude: 25.5197,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      price: 499,
      rating: 4.7,
      durationDays: 4,
    ),

    TourPackageEntity(
      id: 'pkg6',
      title: 'Alexandria Heritage Journey',
      location: LocationEntity(
        address: 'Alexandria',
        latitude: 31.2001,
        longitude: 29.9187,
      ),
      imageUrl: 'https://images.unsplash.com/photo-1539768942893-daf53e448371',
      price: 329,
      rating: 4.6,
      durationDays: 2,
    ),
  ];
  static const plannerPreviews = [
    PlannerPreview(
      title: 'A Perfect Day in Old Cairo',
      imageUrl: 'https://images.unsplash.com/photo-1572252009286-268acec5ca0a',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '08:30 AM', label: 'Khan El Khalili'),
        PlannerStop(time: '10:30 AM', label: 'Al-Muizz Street'),
        PlannerStop(time: '01:00 PM', label: 'El Fishawy Café'),
        PlannerStop(time: '03:30 PM', label: 'Sultan Hassan Mosque'),
        PlannerStop(time: '06:00 PM', label: 'Nile Sunset'),
      ],
    ),

    PlannerPreview(
      title: 'Siwa Wellness Escape',
      imageUrl: 'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '08:00 AM', label: 'Siwa Salt Lakes'),
        PlannerStop(time: '11:00 AM', label: 'Cleopatra Pool'),
        PlannerStop(time: '02:00 PM', label: 'Temple of Amun'),
        PlannerStop(time: '05:00 PM', label: 'Desert Safari'),
        PlannerStop(time: '07:00 PM', label: 'Sunset Camp'),
      ],
    ),

    PlannerPreview(
      title: 'Fayoum Adventure Day',
      imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '09:00 AM', label: 'Wadi El Rayan'),
        PlannerStop(time: '11:30 AM', label: 'Waterfalls'),
        PlannerStop(time: '01:00 PM', label: 'Magic Lake'),
        PlannerStop(time: '03:30 PM', label: 'Sandboarding'),
        PlannerStop(time: '06:00 PM', label: 'Campfire Sunset'),
      ],
    ),

    PlannerPreview(
      title: 'Alexandria Heritage Route',
      imageUrl: 'https://images.unsplash.com/photo-1539768942893-daf53e448371',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '09:00 AM', label: 'Qaitbay Citadel'),
        PlannerStop(time: '11:00 AM', label: 'Bibliotheca Alexandrina'),
        PlannerStop(time: '01:00 PM', label: 'Seafood Lunch'),
        PlannerStop(time: '04:00 PM', label: 'Roman Amphitheatre'),
        PlannerStop(time: '06:30 PM', label: 'Corniche Walk'),
      ],
    ),

    PlannerPreview(
      title: 'Dahab Diving Experience',
      imageUrl: 'https://images.unsplash.com/photo-1582967788606-a171c1080cb0',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '08:00 AM', label: 'Blue Hole'),
        PlannerStop(time: '11:00 AM', label: 'Coral Reef Dive'),
        PlannerStop(time: '02:00 PM', label: 'Beach Lunch'),
        PlannerStop(time: '04:00 PM', label: 'Laguna Bay'),
        PlannerStop(time: '07:00 PM', label: 'Bedouin Dinner'),
      ],
    ),
  ];
}
