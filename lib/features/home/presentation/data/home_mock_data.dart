import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

//!Dummy data for the home screen **Not working right now**
class HomeMockData {
  const HomeMockData._();

  static const banners = [
    BannerEntity(
      id: 'b1',
      title: 'Your AI Travel Planner',
      imageUrl: 'assets/images/banner/banner_1.webp',
    ),
    BannerEntity(
      id: 'b2',
      title: 'Build the Perfect Itinerary',
      imageUrl: 'assets/images/banner/banner_2.webp',
    ),
    BannerEntity(
      id: 'b3',
      title: 'Relax While AI Plans Everything',
      imageUrl: 'assets/images/banner/banner_3.webp',
    ),
    BannerEntity(
      id: 'b4',
      title: 'Discover Your Next Adventure',
      imageUrl: 'assets/images/banner/banner_4.webp',
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
