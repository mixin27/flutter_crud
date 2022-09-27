import 'package:dartz/dartz.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:smf_core/smf_core.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteService _remoteService;
  final ArticleLocalService _localService;

  ArticleRepositoryImpl(this._remoteService, this._localService);

  @override
  Future<Either<ArticleFailure, DomainResult<List<ArticleModel>>>>
      getAllArticles() async {
    try {
      final result = await _remoteService.getAllArticles();
      return right(
        await result.when(
          noConnection: () async {
            final localItems = await _localService.getAllArticles();
            if (localItems.isEmpty) return const DomainResult.noConnection();
            return DomainResult.result(localItems.domainList);
          },
          withData: (data) async {
            await _localService.addAll(data.posts);
            return DomainResult.result(data.posts.domainList);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(ArticleFailure.api(e.errorCode, e.message));
    }
  }
}
