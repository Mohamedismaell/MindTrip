import 'package:equatable/equatable.dart';

class GooglePlaceOpeningHoursModel extends Equatable {
  final bool? openNow;
  final List<String> weekdayDescriptions;

  const GooglePlaceOpeningHoursModel({
    this.openNow,
    this.weekdayDescriptions = const [],
  });

  factory GooglePlaceOpeningHoursModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceOpeningHoursModel(
      openNow: json['open_now'],
      weekdayDescriptions:
          (json['weekday_text'] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  List<Object?> get props => [openNow, weekdayDescriptions];
}
