import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/place_category.dart';

class CategoryModel extends Equatable {
  final String name;
  //* Helpful for UI state
  final bool isSelected;

  final PlaceCategory type;

  const CategoryModel({
    required this.name,
    required this.isSelected,
    this.type = PlaceCategory.other,
  });

  factory CategoryModel.fromEnum(
    PlaceCategory category, {
    bool isSelected = false,
  }) {
    return CategoryModel(
      name: category.displayName,
      isSelected: isSelected,
      type: category,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      isSelected: json['isSelected'] ?? false,
      type: PlaceCategory.fromCategory(json['type'] ?? json['id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'isSelected': isSelected, 'type': type.name};
  }

  @override
  List<Object?> get props => [name, isSelected, type];
}
