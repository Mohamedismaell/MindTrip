import 'package:equatable/equatable.dart';

//Todo Change later to enum that connect to the real data
class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String? emoji;
  final String? imageUrl;
  //* Helpful for UI state
  final bool isSelected;

  const CategoryModel({
    required this.id,
    required this.name,
    this.emoji,
    this.imageUrl,
    required this.isSelected,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      emoji: json['emoji'] ?? '',
      //! Take Care Eith Empty Urls
      imageUrl: json['imageUrl'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'imageUrl': imageUrl,
      'isSelected': isSelected,
    };
  }

  @override
  List<Object?> get props => [id, name, emoji, imageUrl, isSelected];
}
