import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class PlacesMockData {
  static const mockPlaces = [
    PlaceModel(
      id: '1',
      name: 'The Fancy Restaurant',
      location: LocationModel(
        address: '123 Food Street',
        latitude: 31.2710191,
        longitude: 32.269965,
      ),
      thumbnailUrl:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      categoryId: 'restaurant',
    ),
    PlaceModel(
      id: '2',
      name: 'Grand Luxury Hotel',
      location: LocationModel(
        address: '456 Sleep Ave',
        latitude: 30.0454,
        longitude: 31.2367,
      ),
      thumbnailUrl:
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      categoryId: 'hotel',
    ),
    PlaceModel(
      id: '3',
      name: 'Sunny Beach Resort',
      location: LocationModel(
        address: '789 Wave Blvd',
        latitude: 30.0464,
        longitude: 31.2377,
      ),
      thumbnailUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      categoryId: 'beach',
    ),
    PlaceModel(
      id: '4',
      name: 'National Museum',
      location: LocationModel(
        address: '101 History Lane',
        latitude: 30.0474,
        longitude: 31.2387,
      ),
      thumbnailUrl:
          'https://images.unsplash.com/photo-1505761671935-60b3a7427bad',
      categoryId: 'museum',
    ),
  ];
}
