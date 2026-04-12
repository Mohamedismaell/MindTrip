import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

/// Dummy data for the Explore screen — static UI only.
class ExploreMockData {
  const ExploreMockData._();

  // ── Categories ─────────────────────────────────────────────
  static const categories = [
    ExploreCategory(emoji: '✨', label: 'All Categories', isSelected: true),
    ExploreCategory(emoji: '🏖️', label: 'Beach'),
    ExploreCategory(emoji: '⛰️', label: 'Mountain'),
    ExploreCategory(emoji: '🏜️', label: 'Desert'),
    ExploreCategory(emoji: '🤿', label: 'Diving'),
  ];

  // ── Tabs ───────────────────────────────────────────────────
  static const tabs = [
    ExploreTab(label: 'All', isSelected: true),
    ExploreTab(label: 'Places'),
    ExploreTab(label: 'Trips'),
    ExploreTab(label: 'Activities'),
  ];

  // ── Trending Now ───────────────────────────────────────────
  static const trendingPlaces = [
    ExploreTrending(
      title: 'Nile Cafe',
      imageUrl:
          'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
    ),
    ExploreTrending(
      title: 'Sokhna Beach',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    ),
    ExploreTrending(
      title: 'Siwa Oasis',
      imageUrl:
          'https://images.unsplash.com/photo-1596627116790-af6f46dddbfb?w=400',
    ),
    ExploreTrending(
      title: 'Dahab Coast',
      imageUrl:
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
    ),
    ExploreTrending(
      title: 'Aswan Nile',
      imageUrl:
          'https://images.unsplash.com/photo-1568322503193-d7a3a9e32513?w=400',
    ),
    ExploreTrending(
      title: 'Fayoum Lake',
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
    ),
    ExploreTrending(
      title: 'Luxor Sunset',
      imageUrl:
          'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=400',
    ),
    ExploreTrending(
      title: 'Marsa Alam',
      imageUrl:
          'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
    ),
  ];

  // ── Other Places (grid) ────────────────────────────────────
  static const otherPlaces = [
    ExplorePlace(
      title: 'Giza Pyramids',
      location: 'Giza',
      imageUrl:
          'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=400',
      rating: 4.5,
      price: '180\$',
      badge: ExploreBadge.topRated,
    ),
    ExplorePlace(
      title: 'Luxor Temple',
      location: 'Luxor',
      imageUrl:
          'https://images.unsplash.com/photo-1568322503193-d7a3a9e32513?w=400',
      rating: 4.6,
      price: '180\$',
      badge: ExploreBadge.popular,
    ),
    ExplorePlace(
      title: 'Blue Hole',
      location: 'Dahab',
      imageUrl:
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      rating: 4.5,
      price: '180\$',
      badge: ExploreBadge.trending,
    ),
    ExplorePlace(
      title: 'Old Cairo',
      location: 'Cairo',
      imageUrl:
          'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
      rating: 4.5,
      price: '180\$',
      badge: ExploreBadge.topRated,
    ),
    ExplorePlace(
      title: 'Nile Cruise',
      location: 'Aswan',
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
      rating: 4.5,
      price: '180\$',
      badge: ExploreBadge.popular,
    ),
    ExplorePlace(
      title: 'Karnak Temple',
      location: 'Luxor',
      imageUrl:
          'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=400',
      rating: 4.5,
      price: '180\$',
      badge: ExploreBadge.trending,
    ),
  ];

  // ── Filter Locations ───────────────────────────────────────
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
