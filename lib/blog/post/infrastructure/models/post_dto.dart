import 'package:flutter_crud/blog/post/feat_post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
class PostDto with _$PostDto {
  const PostDto._();
  const factory PostDto({
    @JsonKey(name: 'PostID', fromJson: stringFromJson) required String id,
    @JsonKey(name: 'UserID', fromJson: stringFromJson) required String userId,
    @JsonKey(name: 'PostDate', fromJson: stringFromJson) required String date,
    @JsonKey(name: 'PostTitle', fromJson: stringFromJson) required String title,
    @JsonKey(name: 'PostContent', fromJson: stringFromJson)
        required String content,
    @JsonKey(name: 'AuthorName', fromJson: stringFromJson)
        required String author,
    @JsonKey(name: 'PostStatus', fromJson: stringFromJson)
        required String status,
    @JsonKey(name: 'PostCategoryID', fromJson: stringFromJson)
        required String categoryId,
    @JsonKey(name: 'PostCategoryName', fromJson: stringFromJson)
        required String categoryName,
    @JsonKey(name: 'CreatedOn', fromJson: stringFromJson)
        required String createdAt,
    @JsonKey(name: 'CreatedBy', fromJson: stringFromJson)
        required String createdBy,
    @JsonKey(name: 'ModifiedOn', fromJson: stringFromJson)
        required String updatedAt,
    @JsonKey(name: 'ModifiedBy', fromJson: stringFromJson)
        required String updatedBy,
    @JsonKey(name: 'Active', fromJson: boolFromJson) required bool active,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  PostModel get domainModel => toDomain();
  PostModel toDomain() => PostModel(
        id: id,
        userId: userId,
        date: date,
        title: title,
        content: content,
        author: author,
        status: status,
        categoryId: categoryId,
        categoryName: categoryName,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        active: active,
      );
}
