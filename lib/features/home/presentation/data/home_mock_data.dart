import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/data/models/banner_model.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/data/models/tour_package_model.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

//!Dummy data for the home screen **Not working right now**
class HomeMockData {
  const HomeMockData._();

  static const String profileImageUrl =
      'https://www.figma.com/api/mcp/asset/349806fb-b571-4ea9-a856-5ee20e752ca5';

  static const categories = [
    PlaceCategory.heritage,
    PlaceCategory.camping,
    PlaceCategory.beach,
    PlaceCategory.wellness,
    PlaceCategory.diving,
  ];

  static const banners = [
    BannerModel(
      id: 'b1',
      title: 'Escape the Noise',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/27a1b2d0-178d-43c6-a2cb-f6d785526666',
    ),
    BannerModel(
      id: 'b2',
      title: 'Seek Adventure',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/fb3d5dd3-5857-4e1c-b4d0-11c97a44acb7',
    ),
    BannerModel(
      id: 'b3',
      title: 'Travel Through Time',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/9b1d2d74-6b55-4029-8ce3-bec7ae130875',
    ),
  ];

  static const popularDestinations = [
    PlaceModel(
      id: 'p1',
      name: 'The Blue Hole',
      location: LocationModel(address: 'Dahab', latitude: 20, longitude: 30),
      category: PlaceCategory.diving,
      imageUrls: [
        'https://www.figma.com/api/mcp/asset/b9754e96-0dbc-4221-8692-a92c88ba8c1e',
        'https://www.figma.com/api/mcp/asset/36e89b13-c752-4451-9f03-ecc842328398',
        'https://www.figma.com/api/mcp/asset/e084fbc7-7d7f-4e9f-b765-09050f8d88a4',
      ],
    ),
    PlaceModel(
      id: 'p2',
      name: 'White Desert',
      location: LocationModel(address: 'Farafra', latitude: 20, longitude: 30),
      category: PlaceCategory.desert,
      imageUrls: [
        'https://www.figma.com/api/mcp/asset/7757b795-65f2-4a3e-9fa8-78d17c1ad58c',
        'https://www.figma.com/api/mcp/asset/7ca7a24d-98e1-4160-b8a6-25ad588d9515',
      ],
    ),
    PlaceModel(
      id: 'p3',
      name: 'Siwa Salt Lakes',
      location: LocationModel(address: 'Siwa', latitude: 20, longitude: 30),
      category: PlaceCategory.wellness,
      imageUrls: [
        'https://www.figma.com/api/mcp/asset/6d50a379-383d-4729-8571-6371ac253ff9',
        'https://www.figma.com/api/mcp/asset/da6358cf-1d2d-48c6-a12f-8a35c6430944',
      ],
    ),
  ];

  static const recommendedDestinations = [
    PlaceModel(
      id: 'p4',
      name: 'Fjord Bay',
      location: LocationModel(address: 'Taba', latitude: 20, longitude: 30),
      price: 150,
      category: PlaceCategory.beach,
    ),
    PlaceModel(
      id: 'p5',
      name: 'Wadi El Rayan',
      location: LocationModel(address: 'Fayoum', latitude: 20, longitude: 30),
      price: 150,
      category: PlaceCategory.park,
    ),
    PlaceModel(
      id: 'p6',
      name: 'Ras Mohamed',
      location: LocationModel(
        address: 'Sharm El Sheikh',
        latitude: 20,
        longitude: 30,
      ),
      price: 150,
      category: PlaceCategory.diving,
    ),
    PlaceModel(
      id: 'p7',
      name: 'Qaitbay Citadel',
      location: LocationModel(
        address: 'Alexandria',
        latitude: 20,
        longitude: 30,
      ),
      price: 150,
      category: PlaceCategory.heritage,
    ),
    PlaceModel(
      id: 'p8',
      name: 'Mount Sinai',
      location: LocationModel(
        address: 'St. Catherine',
        latitude: 20,
        longitude: 30,
      ),
      price: 150,
      category: PlaceCategory.mountain,
    ),
    PlaceModel(
      id: 'p9',
      name: 'Cleopatra\'s Pool',
      location: LocationModel(address: 'Siwa', latitude: 20, longitude: 30),
      price: 150,
      category: PlaceCategory.wellness,
    ),
    PlaceModel(
      id: 'p10',
      name: 'Khan el-Khalili',
      location: LocationModel(address: 'Cairo', latitude: 20, longitude: 30),
      price: 150,
      category: PlaceCategory.shopping,
    ),
    PlaceModel(
      id: 'p11',
      name: 'Wadi El Gemal',
      location: LocationModel(
        address: 'Marsa Alam',
        latitude: 20,
        longitude: 30,
      ),
      price: 150,
      category: PlaceCategory.beach,
    ),
  ];

  static const tourPackages = [
    TourPackageModel(
      id: 'pkg1',
      title: 'Magic Lake Escape',
      location: LocationModel(address: 'Fayoum', latitude: 20, longitude: 30),
      imageUrl:
          'https://www.figma.com/api/mcp/asset/b57bb337-5ceb-4f23-b123-b5f5424d72e2',
      price: 350,
      rating: 4.5,
      durationDays: 3,
    ),
    TourPackageModel(
      id: 'pkg2',
      title: 'White Desert',
      location: LocationModel(address: 'Farafra', latitude: 20, longitude: 30),
      imageUrl:
          'https://www.figma.com/api/mcp/asset/7ca7a24d-98e1-4160-b8a6-25ad588d9515',
      price: 350,
      rating: 4.7,
      durationDays: 2,
    ),
    TourPackageModel(
      id: 'pkg3',
      title: 'Aswan Getaway',
      location: LocationModel(address: 'Aswan', latitude: 20, longitude: 30),
      imageUrl:
          'https://www.figma.com/api/mcp/asset/d79ef4b5-b669-4d5c-82d6-f7a4fed5c5e4',
      price: 390,
      rating: 4.6,
      durationDays: 4,
    ),
  ];

  static const plannerPreviews = [
    PlannerPreview(
      title: 'A Perfect Day in Old Cairo',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/a397bc09-6b25-4478-bee7-2dd2b7e3b5df',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '10:00 AM', label: 'Breakfast'),
        PlannerStop(time: '12:30 PM', label: 'AlMuizz'),
        PlannerStop(time: '04:00 PM', label: 'Sunset'),
        PlannerStop(time: '07:00 PM', label: 'Shopping'),
      ],
    ),
    PlannerPreview(
      title: 'Siwa Detox Day',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/b860fb20-8a29-420f-8266-e9104d6b628e',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '09:00 AM', label: 'Lakes'),
        PlannerStop(time: '12:00 PM', label: 'Pool'),
        PlannerStop(time: '04:00 PM', label: 'Sunset'),
        PlannerStop(time: '08:00 PM', label: 'Dinner'),
      ],
    ),
    PlannerPreview(
      title: 'Fayoum Action Day',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/2c0bf72c-d62e-4e8f-8d88-09aeadffc85c',
      badge: 'AI Crafted',
      stops: [
        PlannerStop(time: '10:00 AM', label: 'Safari'),
        PlannerStop(time: '01:00 PM', label: 'Sandboard'),
        PlannerStop(time: '04:00 PM', label: 'Felucca'),
        PlannerStop(time: '06:00 PM', label: 'Campfire'),
      ],
    ),
  ];
}
