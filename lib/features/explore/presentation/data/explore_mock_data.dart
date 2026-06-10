import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

/// Dummy data for the Explore screen — static UI only.
class ExploreMockData {
  const ExploreMockData._();

  //  Categories
  static const categories = [
    PlaceCategory.all,
    PlaceCategory.beach,
    PlaceCategory.mountain,
    PlaceCategory.desert,
    PlaceCategory.diving,
    PlaceCategory.restaurant,
    PlaceCategory.hotel,
  ];

  //  Tabs
  static const tabs = [
    ExploreTab(label: 'All', isSelected: true),
    ExploreTab(label: 'Places', isSelected: false),
    ExploreTab(label: 'Trips', isSelected: false),
    ExploreTab(label: 'Activities', isSelected: false),
  ];

  //  Trending Now
  static const trendingPlaces = [
    PlaceEntity(
      id: 't1',
      name: 'Nile Cafe',
      location: LocationEntity(
        address: 'Cairo',
        latitude: 30.0,
        longitude: 31.2,
      ),
      description: 'A beautiful cafe on the Nile.',
      rating: 4.5,
      price: null,
      category: PlaceCategory.restaurant,
      imageUrls: [
        'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
      ],
    ),
    PlaceEntity(
      id: 't2',
      name: 'Sokhna Beach',
      location: LocationEntity(
        address: 'Ain Sokhna',
        latitude: 29.5984,
        longitude: 32.3157,
      ),
      description: 'Relaxing beach resort.',
      rating: 4.2,
      price: 4000,
      category: PlaceCategory.beach,
      imageUrls: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      ],
    ),
    PlaceEntity(
      id: 't3',
      name: 'Siwa Oasis',
      location: LocationEntity(
        address: 'Siwa',
        latitude: 29.2077,
        longitude: 25.5366,
      ),
      description: 'Historical oasis in the desert.',
      rating: 4.8,
      price: null,
      category: PlaceCategory.desert,
      imageUrls: [
        'https://images.unsplash.com/photo-1596627116790-af6f46dddbfb?w=400',
      ],
    ),
    PlaceEntity(
      id: 't4',
      name: 'Dahab Coast',
      location: LocationEntity(
        address: 'Dahab',
        latitude: 28.4905,
        longitude: 34.5163,
      ),
      description: 'World famous diving spot.',
      rating: 4.9,
      price: null,
      category: PlaceCategory.diving,
      imageUrls: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      ],
    ),
    PlaceEntity(
      id: 't5',
      name: 'Aswan Nile',
      location: LocationEntity(
        address: 'Aswan',
        latitude: 24.0882,
        longitude: 32.8992,
      ),
      description: 'Sail the Nile in a felucca.',
      rating: 4.7,
      price: null,
      category: PlaceCategory.activity,
      imageUrls: [
        'https://images.unsplash.com/photo-1568322503193-d7a3a9e32513?w=400',
      ],
    ),
    PlaceEntity(
      id: 't6',
      name: 'Fayoum Lake',
      location: LocationEntity(
        address: 'Fayoum',
        latitude: 29.2999,
        longitude: 30.6445,
      ),
      description: 'Scenic lake and waterfalls.',
      rating: 4.4,
      price: null,
      category: PlaceCategory.park,
      imageUrls: [
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
      ],
    ),
    PlaceEntity(
      id: 't7',
      name: 'Luxor Sunset',
      location: LocationEntity(
        address: 'Luxor',
        latitude: 25.6996,
        longitude: 32.6386,
      ),
      description: 'Watch the sunset over the ancient temples.',
      rating: 4.9,
      price: null,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=400',
      ],
    ),
    PlaceEntity(
      id: 't8',
      name: 'Marsa Alam',
      location: LocationEntity(
        address: 'Marsa Alam',
        latitude: 25.4428,
        longitude: 34.3384,
      ),
      description: 'Pristine beaches and coral reefs.',
      rating: 4.6,
      price: null,
      category: PlaceCategory.beach,
      imageUrls: [
        'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
      ],
    ),
  ];

  //  Other Places (grid)
  static const otherPlaces = [
    PlaceEntity(
      id: 'op_t1',
      name: 'Nile Cafe',
      location: LocationEntity(
        address: 'Cairo',
        latitude: 30.0,
        longitude: 31.2,
      ),
      description: 'A beautiful cafe on the Nile.',
      rating: 4.5,
      price: 4141,
      category: PlaceCategory.restaurant,
      imageUrls: [
        'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t2',
      name: 'Sokhna Beach',
      location: LocationEntity(
        address: 'Ain Sokhna',
        latitude: 29.5984,
        longitude: 32.3157,
      ),
      description: 'Relaxing beach resort.',
      rating: 4.2,
      price: 1402220,
      category: PlaceCategory.hotel,
      imageUrls: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t3',
      name: 'Siwa Oasis',
      location: LocationEntity(
        address: 'Siwa',
        latitude: 29.2077,
        longitude: 25.5366,
      ),
      description: 'Historical oasis in the desert.',
      rating: 4.8,
      price: null,
      category: PlaceCategory.desert,
      imageUrls: [
        'https://images.unsplash.com/photo-1596627116790-af6f46dddbfb?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t4',
      name: 'Dahab Coast',
      location: LocationEntity(
        address: 'Dahab',
        latitude: 28.4905,
        longitude: 34.5163,
      ),
      description: 'World famous diving spot.',
      rating: 4.9,
      price: null,
      category: PlaceCategory.diving,
      imageUrls: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t5',
      name: 'Aswan Nile',
      location: LocationEntity(
        address: 'Aswan',
        latitude: 24.0882,
        longitude: 32.8992,
      ),
      description: 'Sail the Nile in a felucca.',
      rating: 4.7,
      price: null,
      category: PlaceCategory.activity,
      imageUrls: [
        'https://images.unsplash.com/photo-1568322503193-d7a3a9e32513?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t6',
      name: 'Fayoum Lake',
      location: LocationEntity(
        address: 'Fayoum',
        latitude: 29.2999,
        longitude: 30.6445,
      ),
      description: 'Scenic lake and waterfalls.',
      rating: 4.4,
      price: null,
      category: PlaceCategory.park,
      imageUrls: [
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t7',
      name: 'Luxor Sunset',
      location: LocationEntity(
        address: 'Luxor',
        latitude: 25.6996,
        longitude: 32.6386,
      ),
      description: 'Watch the sunset over the ancient temples.',
      rating: 4.9,
      price: null,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op_t8',
      name: 'Marsa Alam',
      location: LocationEntity(
        address: 'Marsa Alam',
        latitude: 25.4428,
        longitude: 34.3384,
      ),
      description: 'Pristine beaches and coral reefs.',
      rating: 4.6,
      price: null,
      category: PlaceCategory.beach,
      imageUrls: [
        'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
      ],
    ),
    PlaceEntity(
      id: 'op1',
      name: 'Giza Pyramids',
      location: LocationEntity(
        address: 'Giza',
        latitude: 29.9792,
        longitude: 31.1342,
      ),
      description: 'The Great Pyramids of Giza.',
      rating: 4.5,
      price: 180.0,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=400',
      ],
      // badge: PlaceBadge.topRated,
    ),
    PlaceEntity(
      id: 'op2',
      name: 'Luxor Temple',
      location: LocationEntity(
        address: 'Luxor',
        latitude: 25.6996,
        longitude: 32.6386,
      ),
      description: 'Ancient Egyptian temple complex.',
      rating: 4.6,
      price: 180.0,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1568322503193-d7a3a9e32513?w=400',
      ],
      // badge: PlaceBadge.popular,
    ),
    PlaceEntity(
      id: 'op3',
      name: 'Blue Hole',
      location: LocationEntity(
        address: 'Dahab',
        latitude: 28.4905,
        longitude: 34.5163,
      ),
      description: 'Famous submarine sinkhole.',
      rating: 4.5,
      price: 180.0,
      category: PlaceCategory.diving,
      imageUrls: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      ],
      // // badge: PlaceBadge.trending,
    ),
    PlaceEntity(
      id: 'op4',
      name: 'Old Cairo',
      location: LocationEntity(
        address: 'Cairo',
        latitude: 30.0444,
        longitude: 31.2357,
      ),
      description: 'Historic district of Cairo.',
      rating: 4.5,
      price: 180.0,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
      ],
      // // badge: PlaceBadge.topRated,
    ),
    PlaceEntity(
      id: 'op5',
      name: 'Nile Cruise',
      location: LocationEntity(
        address: 'Aswan',
        latitude: 24.0882,
        longitude: 32.8992,
      ),
      description: 'Cruise down the Nile river.',
      rating: 4.5,
      price: 180.0,
      category: PlaceCategory.trip,
      imageUrls: [
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
      ],
      // // badge: PlaceBadge.popular,
    ),
    PlaceEntity(
      id: 'op6',
      name: 'Karnak Temple',
      location: LocationEntity(
        address: 'Luxor',
        latitude: 25.6996,
        longitude: 32.6386,
      ),
      description: 'Vast mix of decayed temples.',
      rating: 4.5,
      price: 180.0,
      category: PlaceCategory.heritage,
      imageUrls: [
        'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=400',
      ],
      // badge: PlaceBadge.trending,
    ),
  ];

  //  Filter Locations ─
  static const filterLocations = [
    'South Sinai',
    'Cairo',
    'Dahab',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Fayoum',
  ];
}
