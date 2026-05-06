import 'package:equatable/equatable.dart';

class GooglePlaceOpeningHoursEntity extends Equatable {
  final bool? openNow;
  final List<String> weekdayDescriptions;

  const GooglePlaceOpeningHoursEntity({
    this.openNow,
    this.weekdayDescriptions = const [],
  });

  @override
  List<Object?> get props => [openNow, weekdayDescriptions];
}
