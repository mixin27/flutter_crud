import 'package:dartz/dartz.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:smf_core/smf_core.dart';

abstract class ArticleRepository {
  Future<Either<ArticleFailure, DomainResult<List<ArticleModel>>>>
      getAllArticles();
}
