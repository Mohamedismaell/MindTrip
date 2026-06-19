import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

class DummyData {
  static const banner = BannerEntity(
    id: 'dummy',
    title: 'Dummy Banner Title Placeholder',
    imageUrl: '',
  );

  static const location = LocationEntity(
    address: 'Dummy Address, City, Country',
    latitude: 0.0,
    longitude: 0.0,
    city: 'Egypt',
    cityEn: 'Egypt',
  );

  static const place = PlaceEntity(
    id: 'dummy',
    name: 'Dummy Place Name',
    location: location,
    imageUrls: [
      'assets/images/authentication/center_vec.webp',
      'assets/images/authentication/center_vec.webp',
    ],
  );
  static const placeDetails = PlaceEntity(
    id: '',
    name: 'Place Name Placeholder',
    description:
        'This is a long description placeholder that will be skeletonized. It should span multiple lines to show the effect properly.',
    location: LocationEntity(
      address: 'City, Country',
      latitude: 0,
      longitude: 0,
      city: '',
      cityEn: '',
    ),
    rating: 5.0,
    reviewCount: 0,
  );

  static final exploreCardPlaces = List.generate(
    6,
    (index) => PlaceEntity(
      id: 'recommended_place_$index',
      name: place.name,
      location: place.location,
      imageUrls: place.imageUrls,
    ),
  );
  static final plannerPreview = PlannerPreviewEntity(
    title: 'Dummy Trip Title',
    imageUrl: '',
    badge: 'Popular',
    stops: [
      const PlannerStopEntity(
        time: '09:00 AM',
        label: 'First Stop Placeholder',
      ),
      const PlannerStopEntity(
        time: '01:00 PM',
        label: 'Second Stop Placeholder',
      ),
    ],
  );

  static final banners = List.generate(
    1,
    (index) => BannerEntity(
      id: 'banner_$index',
      title: banner.title,
      imageUrl: banner.imageUrl,
    ),
  );

  static final popularPlaces = List.generate(
    3,
    (index) => PlaceEntity(
      id: 'popular_place_$index',
      name: place.name,
      location: place.location,
      imageUrls: place.imageUrls,
    ),
  );

  static final recommendedPlaces = List.generate(
    6,
    (index) => PlaceEntity(
      id: 'recommended_place_$index',
      name: place.name,
      location: place.location,
      imageUrls: place.imageUrls,
    ),
  );
  static final categoryPlaces = List.generate(
    6,
    (index) => PlaceEntity(
      id: 'recommended_place_$index',
      name: place.name,
      location: place.location,
      imageUrls: place.imageUrls,
    ),
  );

  static final plannerPreviews = List.generate(
    2,
    (index) => PlannerPreviewEntity(
      title: plannerPreview.title,
      imageUrl: plannerPreview.imageUrl,
      badge: plannerPreview.badge,
      stops: plannerPreview.stops,
    ),
  );
}
