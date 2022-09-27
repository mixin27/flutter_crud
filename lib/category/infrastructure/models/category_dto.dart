import 'package:floor/floor.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: 'PostCategoryID', fromJson: stringFromJson)
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @JsonKey(name: 'PostCategoryName', fromJson: stringFromJson)
  @ColumnInfo(name: 'name')
  final String name;

  @JsonKey(name: 'Active', fromJson: boolFromJson)
  @ColumnInfo(name: 'active')
  final bool active;

  CategoryDto({
    required this.id,
    required this.name,
    required this.active,
  });

  /// Connect the generated [_$CategoryDtoFromJson] function to the `fromJson`
  /// factory.
  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  /// Connect the generated [_$CategoryDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoryModel get domainModel => toDomain();
  CategoryModel toDomain() => CategoryModel(id: id, name: name, active: active);

  CategoryDto copyWith({
    String? id,
    String? name,
    bool? active,
  }) {
    return CategoryDto(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  @override
  String toString() => 'CategoryDto(id: $id, name: $name, active: $active)';

  @override
  bool operator ==(covariant CategoryDto other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.active == active;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ active.hashCode;
}
