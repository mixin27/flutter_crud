import 'package:floor/floor.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'article_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'articles')
class ArticleDto {
  @JsonKey(name: 'PostID', fromJson: stringFromJson)
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @JsonKey(name: 'PostDate', fromJson: stringFromJson)
  @ColumnInfo(name: 'published_at')
  final String publishedAt;

  @JsonKey(name: 'PostTitle', fromJson: stringFromJson)
  @ColumnInfo(name: 'title')
  final String title;

  @JsonKey(name: 'PostContent', fromJson: stringFromJson)
  @ColumnInfo(name: 'content')
  final String content;

  @JsonKey(name: 'PostStatus', fromJson: stringFromJson)
  @ColumnInfo(name: 'status')
  final String status;

  @JsonKey(name: 'PostCategoryID', fromJson: stringFromJson)
  @ColumnInfo(name: 'category_id')
  final String categoryId;

  @JsonKey(name: 'PostCategoryName', fromJson: stringFromJson)
  @ColumnInfo(name: 'category_name')
  final String categoryName;

  @JsonKey(name: 'CreatedOn', fromJson: stringFromJson)
  @ColumnInfo(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'AuthorName', fromJson: stringFromJson)
  @ColumnInfo(name: 'author_name')
  final String author;

  @JsonKey(name: 'UserID', fromJson: stringFromJson)
  @ColumnInfo(name: 'author_id')
  final String authorId;

  @JsonKey(name: 'Active', fromJson: boolFromJson)
  @ColumnInfo(name: 'active')
  final bool active;

  ArticleDto({
    required this.id,
    required this.publishedAt,
    required this.title,
    required this.content,
    required this.status,
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.author,
    required this.authorId,
    required this.active,
  });

  /// Connect the generated [_$ArticleDtoFromJson] function to the `fromJson`
  /// factory.
  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  /// Connect the generated [_$ArticleDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticleDtoToJson(this);

  ArticleModel get domainModel => toDomain();
  ArticleModel toDomain() => ArticleModel(
        id: id,
        publishedAt: publishedAt,
        title: title,
        content: content,
        status: status,
        categoryId: categoryId,
        categoryName: categoryName,
        createdAt: createdAt,
        author: author,
        authorId: authorId,
        active: active,
      );

  ArticleDto copyWith({
    String? id,
    String? publishedAt,
    String? title,
    String? content,
    String? status,
    String? categoryId,
    String? categoryName,
    String? createdAt,
    String? author,
    String? authorId,
    bool? active,
  }) {
    return ArticleDto(
      id: id ?? this.id,
      publishedAt: publishedAt ?? this.publishedAt,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      createdAt: createdAt ?? this.createdAt,
      author: author ?? this.author,
      authorId: authorId ?? this.authorId,
      active: active ?? this.active,
    );
  }

  @override
  String toString() {
    return 'ArticleDto(id: $id, published: $publishedAt, title: $title, content: $content, status: $status, categoryId: $categoryId, categoryName: $categoryName, createdAt: $createdAt, author: $author, authorId: $authorId, active: $active)';
  }

  @override
  bool operator ==(covariant ArticleDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.publishedAt == publishedAt &&
        other.title == title &&
        other.content == content &&
        other.status == status &&
        other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.createdAt == createdAt &&
        other.author == author &&
        other.authorId == authorId &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publishedAt.hashCode ^
        title.hashCode ^
        content.hashCode ^
        status.hashCode ^
        categoryId.hashCode ^
        categoryName.hashCode ^
        createdAt.hashCode ^
        author.hashCode ^
        authorId.hashCode ^
        active.hashCode;
  }
}
