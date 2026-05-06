import 'package:equatable/equatable.dart';

class GooglePlaceEditorialSummaryModel extends Equatable {
  final String overview;

  const GooglePlaceEditorialSummaryModel({required this.overview});

  factory GooglePlaceEditorialSummaryModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceEditorialSummaryModel(
      overview: json['overview'] ?? '',
    );
  }

  @override
  List<Object?> get props => [overview];
}
