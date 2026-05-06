import 'package:equatable/equatable.dart';

class GooglePlacePhotoModel extends Equatable {
  final String photoReference;
  final int heightPx;
  final int widthPx;
  final String? attribution;

  const GooglePlacePhotoModel({
    required this.photoReference,
    required this.heightPx,
    required this.widthPx,
    this.attribution,
  });

  factory GooglePlacePhotoModel.fromJson(Map<String, dynamic> json) {
    return GooglePlacePhotoModel(
      photoReference: json['photo_reference'] ?? '',
      heightPx: json['height'] ?? 0,
      widthPx: json['width'] ?? 0,
      attribution: (json['html_attributions'] as List?)?.firstOrNull,
    );
  }

  factory GooglePlacePhotoModel.fromNearbyJson(Map<String, dynamic> json) {
    return GooglePlacePhotoModel(
      photoReference: json['name'] ?? '',
      heightPx: json['heightPx'] ?? 0,
      widthPx: json['widthPx'] ?? 0,
      attribution:
          (json['authorAttributions'] as List?)?.firstOrNull?['displayName'],
    );
  }

  @override
  List<Object?> get props => [photoReference, heightPx, widthPx, attribution];
}
