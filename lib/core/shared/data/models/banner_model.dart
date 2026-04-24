import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String? targetUrl;

  const BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.targetUrl,
  });
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      targetUrl: json['targetUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'targetUrl': targetUrl,
    };
  }

  @override
  List<Object?> get props => [id, title, imageUrl, targetUrl];
}
