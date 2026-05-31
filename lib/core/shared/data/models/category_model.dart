import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/enums/place_category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @Default('') String name,
    @Default(false) bool isSelected,
    @Default(PlaceCategory.other) PlaceCategory type,
  }) = _CategoryModel;

  const CategoryModel._();

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

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
