import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
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
  );

  static const place = PlaceEntity(
    id: 'dummy',
    name: 'Dummy Place Name',
    location: location,
    imageUrls: ['', ''],
  );

  static const tourPackage = TourPackageEntity(
    id: 'dummy',
    title: 'Dummy Tour Package Title',
    location: location,
    imageUrl: '',
    price: 99.99,
    rating: 4.5,
    durationDays: 3,
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

  static final tourPackages = List.generate(
    3,
    (index) => TourPackageEntity(
      id: 'package_$index',
      title: tourPackage.title,
      location: tourPackage.location,
      imageUrl: tourPackage.imageUrl,
      price: tourPackage.price,
      rating: tourPackage.rating,
      durationDays: tourPackage.durationDays,
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
