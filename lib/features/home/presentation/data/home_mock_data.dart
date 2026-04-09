import 'package:mindtrip/features/home/presentation/models/home_models.dart';

//!Dummy data for the home screen **Not working right now**
class HomeMockData {
  const HomeMockData._();

  static const String profileImageUrl =
      'https://www.figma.com/api/mcp/asset/349806fb-b571-4ea9-a856-5ee20e752ca5';

  static const categories = [
    HomeCategory(emoji: '🏛️', label: 'Heritage', isSelected: true),
    HomeCategory(emoji: '🏕️', label: 'Camping'),
    HomeCategory(emoji: '🌊', label: 'Sea'),
    HomeCategory(emoji: '🧘‍♀️', label: 'Wellness'),
    HomeCategory(emoji: '🐠', label: 'Diving'),
  ];

  static const banners = [
    HomeBanner(
      title: 'Escape the Noise',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/27a1b2d0-178d-43c6-a2cb-f6d785526666',
    ),
    HomeBanner(
      title: 'Seek Adventure',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/fb3d5dd3-5857-4e1c-b4d0-11c97a44acb7',
    ),
    HomeBanner(
      title: 'Travel Through Time',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/9b1d2d74-6b55-4029-8ce3-bec7ae130875',
    ),
  ];

  static const popularDestinations = [
    HomeSpotlight(
      title: 'The Blue Hole',
      location: 'Dahab',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/b9754e96-0dbc-4221-8692-a92c88ba8c1e',
      previewImageUrls: [
        'https://www.figma.com/api/mcp/asset/36e89b13-c752-4451-9f03-ecc842328398',
        'https://www.figma.com/api/mcp/asset/e084fbc7-7d7f-4e9f-b765-09050f8d88a4',
      ],
      extraPhotoCount: 6,
    ),
    HomeSpotlight(
      title: 'White Desert',
      location: 'Farafra',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/7757b795-65f2-4a3e-9fa8-78d17c1ad58c',
      previewImageUrls: [
        'https://www.figma.com/api/mcp/asset/7757b795-65f2-4a3e-9fa8-78d17c1ad58c',
        'https://www.figma.com/api/mcp/asset/7ca7a24d-98e1-4160-b8a6-25ad588d9515',
      ],
      extraPhotoCount: 4,
    ),
    HomeSpotlight(
      title: 'Siwa Salt Lakes',
      location: 'Siwa',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/6d50a379-383d-4729-8571-6371ac253ff9',
      previewImageUrls: [
        'https://www.figma.com/api/mcp/asset/6d50a379-383d-4729-8571-6371ac253ff9',
        'https://www.figma.com/api/mcp/asset/da6358cf-1d2d-48c6-a12f-8a35c6430944',
      ],
      extraPhotoCount: 5,
    ),
  ];

  static const recommendedDestinations = [
    HomeDestination(
      title: 'Fjord Bay',
      location: 'Taba',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/22cd2d99-db30-4dad-b0ef-9d129132111a',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Wadi El Rayan',
      location: 'Fayoum',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/1ee00423-bf80-46b1-97e4-2e8517d39bd3',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Ras Mohamed',
      location: 'Sharm El Sheikh',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/f360b217-4b82-461b-8b48-32ef0035a771',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Qaitbay Citadel',
      location: 'Alexandria',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/52c3d736-a15a-4805-a18e-ce5a92d669cf',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Mount Sinai',
      location: 'St. Catherine',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/e52e4006-7d5b-4df6-9b6e-a476a7c1121f',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Cleopatra\'s Pool',
      location: 'Siwa',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/da6358cf-1d2d-48c6-a12f-8a35c6430944',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Khan el-Khalili',
      location: 'Cairo',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/ad7063f3-8ee5-4a4f-9c0a-a2ae83cda1ac',
      priceTag: '\$150',
    ),
    HomeDestination(
      title: 'Wadi El Gemal',
      location: 'Marsa Alam',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/7b2197bc-327b-4101-8580-147dd65dddf8',
      priceTag: '\$150',
    ),
  ];

  static const tourPackages = [
    HomePackage(
      title: 'Magic Lake Escape',
      location: 'Fayoum',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/b57bb337-5ceb-4f23-b123-b5f5424d72e2',
      price: '\$350 / person',
      rating: 4.5,
    ),
    HomePackage(
      title: 'White Desert',
      location: 'Farafra',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/7ca7a24d-98e1-4160-b8a6-25ad588d9515',
      price: '\$350 / person',
      rating: 4.7,
    ),
    HomePackage(
      title: 'Aswan Getaway',
      location: 'Aswan',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/d79ef4b5-b669-4d5c-82d6-f7a4fed5c5e4',
      price: '\$390 / person',
      rating: 4.6,
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
