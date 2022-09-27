import 'package:flutter_crud/article/feat_article.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final articleDaoProvider = Provider(
  (ref) => ref.watch(appFloorDBProvider).instance.articleDao,
);

final articleLocalServiceProvider = Provider(
  (ref) => ArticleLocalService(
    ref.watch(articleDaoProvider),
  ),
);

final articleRemoteServiceProvider = Provider(
  (ref) => ArticleRemoteService(
    ref.watch(dioProvider),
  ),
);

final articleRepositoryProvider = Provider<ArticleRepository>(
  (ref) => ArticleRepositoryImpl(
    ref.watch(articleRemoteServiceProvider),
    ref.watch(articleLocalServiceProvider),
  ),
);

final getAllArticlesNotifierProvider =
    StateNotifierProvider<GetAllArticlesNotifier, GetAllArticlesState>(
  (ref) => GetAllArticlesNotifier(
    ref.watch(articleRepositoryProvider),
  ),
);
