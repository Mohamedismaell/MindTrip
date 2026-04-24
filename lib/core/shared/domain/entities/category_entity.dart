import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? emoji;
  final String? imageUrl;
  //* Helpful for UI state
  final bool isSelected;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.emoji,
    this.imageUrl,
    this.isSelected = false,
  });

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? emoji,
    String? imageUrl,
    bool? isSelected,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, emoji, imageUrl, isSelected];
}
