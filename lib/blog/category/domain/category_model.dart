import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const CategoryModel._();
  const factory CategoryModel({
    required String id,
    required String name,
    required String createdAt,
    required String createdBy,
    required String updatedAt,
    required String updatedBy,
    required bool active,
  }) = _CategoryModel;
}
