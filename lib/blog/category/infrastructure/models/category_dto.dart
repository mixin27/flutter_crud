import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
class CategoryDto with _$CategoryDto {
  const CategoryDto._();
  const factory CategoryDto({
    @JsonKey(name: 'PostCategoryID', fromJson: stringFromJson)
        required String id,
    @JsonKey(name: 'PostCategoryName', fromJson: stringFromJson)
        required String name,
    @JsonKey(name: 'CreatedOn', fromJson: stringFromJson)
        required String createdAt,
    @JsonKey(name: 'CreatedBy', fromJson: stringFromJson)
        required String createdBy,
    @JsonKey(name: 'ModifiedOn', fromJson: stringFromJson)
        required String updatedAt,
    @JsonKey(name: 'ModifiedBy', fromJson: stringFromJson)
        required String updatedBy,
    @JsonKey(name: 'Active', fromJson: boolFromJson) required bool active,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  CategoryModel get domainModel => toDomain();
  CategoryModel toDomain() => CategoryModel(
        id: id,
        name: name,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        active: active,
      );
}
