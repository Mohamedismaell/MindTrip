import 'package:hive_ce_flutter/adapters.dart';

part 'place_city.g.dart';

@HiveType(typeId: 4)
enum PlaceCity {
  @HiveField(0)
  cairo,

  @HiveField(1)
  giza,

  @HiveField(2)
  alexandria,

  @HiveField(3)
  ismailia,

  @HiveField(4)
  portSaid,

  @HiveField(5)
  luxor,

  @HiveField(6)
  aswan,

  @HiveField(7)
  hurghada,

  @HiveField(8)
  fayoum,

  @HiveField(9)
  sharmElSheikh,

  @HiveField(10)
  marsaMatrouh,

  @HiveField(11)
  other;

  String get category => switch (this) {
    PlaceCity.cairo => 'Cairo',
    PlaceCity.giza => 'Giza',
    PlaceCity.alexandria => 'Alexandria',
    PlaceCity.ismailia => 'Ismailia',
    PlaceCity.portSaid => 'Port Said',
    PlaceCity.luxor => 'Luxor',
    PlaceCity.aswan => 'Aswan',
    PlaceCity.hurghada => 'Hurghada',
    PlaceCity.fayoum => 'Fayoum',
    PlaceCity.sharmElSheikh => 'Sharm El Sheikh',
    PlaceCity.marsaMatrouh => 'Marsa Matrouh',
    PlaceCity.other => 'other',
  };
  String get displayName => switch (this) {
    PlaceCity.cairo => 'Cairo',
    PlaceCity.giza => 'Giza',
    PlaceCity.alexandria => 'Alexandria',
    PlaceCity.ismailia => 'Ismailia',
    PlaceCity.portSaid => 'Port Said',
    PlaceCity.luxor => 'Luxor',
    PlaceCity.aswan => 'Aswan',
    PlaceCity.hurghada => 'Hurghada',
    PlaceCity.fayoum => 'Fayoum',
    PlaceCity.sharmElSheikh => 'Sharm El Sheikh',
    PlaceCity.marsaMatrouh => 'Marsa Matrouh',
    PlaceCity.other => 'Other',
  };

  static PlaceCity fromCategory(String? category) {
    if (category == null) return PlaceCity.other;

    return PlaceCity.values.firstWhere(
      (e) => e.category == category.trim().toLowerCase(),
      orElse: () => PlaceCity.other,
    );
  }
}
