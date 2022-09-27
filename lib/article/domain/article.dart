import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required String id,
    required String publishedAt,
    required String title,
    required String content,
    required String status,
    required String categoryId,
    required String categoryName,
    required String createdAt,
    required String author,
    required String authorId,
    required bool active,
  }) = _ArticleModel;
}
