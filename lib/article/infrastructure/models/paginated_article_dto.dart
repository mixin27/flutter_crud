import 'package:flutter_crud/article/feat_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'paginated_article_dto.freezed.dart';
part 'paginated_article_dto.g.dart';

@freezed
class PaginatedArticleDto with _$PaginatedArticleDto {
  const PaginatedArticleDto._();
  const factory PaginatedArticleDto({
    @JsonKey(name: 'totalRecord', fromJson: stringFromJson)
        required String totalRecord,
    @JsonKey(name: 'totalPage', fromJson: stringFromJson)
        required String totalPage,
    @JsonKey(name: 'currentPageNo', fromJson: stringFromJson)
        required String currentPageNo,
    @JsonKey(name: 'dataList', defaultValue: [])
        required List<ArticleDto> posts,
  }) = _PaginatedArticleDto;

  factory PaginatedArticleDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedArticleDtoFromJson(json);

  int get page => currentPageNo.valInt ?? 0;
  int get total => totalPage.valInt ?? 0;
  int get itemCount => totalRecord.valInt ?? 0;
}
