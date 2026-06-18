import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/features/home/domain/entity/tour_package_entity.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

//!Dummy data for the home screen **Not working right now**
class HomeMockData {
  const HomeMockData._();

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

  static const tourPackages = [
    TourPackageEntity(
      id: 'pkg1',
      title: 'Magic Lake Escape',
      location: LocationEntity(
        address: 'Fayoum',
        latitude: 29.2089,
        longitude: 30.4474,
        city: '',
        cityEn: '',
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
        city: '',
        cityEn: '',
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
        city: '',
        cityEn: '',
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
        city: '',
        cityEn: '',
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
        city: '',
        cityEn: '',
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
        city: '',
        cityEn: '',
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
