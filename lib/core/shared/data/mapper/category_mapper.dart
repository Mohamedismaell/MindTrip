import 'package:mindtrip/core/shared/data/models/category_model.dart';
import 'package:mindtrip/core/shared/domain/entities/category_entity.dart';

extension CategoryMapper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      emoji: emoji,
      imageUrl: imageUrl,
      isSelected: isSelected,
    );
  }
}

extension CategoryEntityMapper on CategoryEntity {
  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      name: name,
      emoji: emoji,
      imageUrl: imageUrl,
      isSelected: isSelected,
    );
  }
}
