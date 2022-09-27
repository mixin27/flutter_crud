import 'package:flutter_crud/article/feat_article.dart';

extension ArticleDtoListX on List<ArticleDto> {
  List<ArticleModel> get domainList => toDomainList();
  List<ArticleModel> toDomainList() => map((e) => e.domainModel).toList();
}
