import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String? targetUrl;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.targetUrl,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, targetUrl];
}
