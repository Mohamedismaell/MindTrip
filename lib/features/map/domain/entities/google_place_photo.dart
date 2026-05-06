import 'package:equatable/equatable.dart';

class GooglePlacePhotoEntity extends Equatable {
  final String photoReference;
  final int height;
  final int width;
  final String? attribution;

  const GooglePlacePhotoEntity({
    required this.photoReference,
    required this.height,
    required this.width,
    this.attribution,
  });

  GooglePlacePhotoEntity copyWith({
    String? photoReference,
    int? height,
    int? width,
    String? attribution,
  }) {
    return GooglePlacePhotoEntity(
      photoReference: photoReference ?? this.photoReference,
      height: height ?? this.height,
      width: width ?? this.width,
      attribution: attribution ?? this.attribution,
    );
  }

  @override
  List<Object?> get props => [
    photoReference,
    height,
    width,
    attribution,
  ];
}
