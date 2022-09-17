import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';

@freezed
class PostModel with _$PostModel {
  const PostModel._();
  const factory PostModel({
    required String id,
    required String userId,
    required String date,
    required String title,
    required String content,
    required String author,
    required String status,
    required String categoryId,
    required String categoryName,
    required String createdAt,
    required String createdBy,
    required String updatedAt,
    required String updatedBy,
    required bool active,
  }) = _PostModel;
}
