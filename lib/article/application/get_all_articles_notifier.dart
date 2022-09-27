import 'package:flutter_crud/article/feat_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_all_articles_notifier.freezed.dart';

@freezed
class GetAllArticlesState with _$GetAllArticlesState {
  const factory GetAllArticlesState.initial() = _Initial;
  const factory GetAllArticlesState.loading() = _Loading;
  const factory GetAllArticlesState.empty() = _Empty;
  const factory GetAllArticlesState.noConnection() = _NoConnection;
  const factory GetAllArticlesState.success(List<ArticleModel> articles) =
      _Success;
  const factory GetAllArticlesState.error(ArticleFailure failure) = _Error;
}

class GetAllArticlesNotifier extends StateNotifier<GetAllArticlesState> {
  final ArticleRepository _repository;

  GetAllArticlesNotifier(this._repository)
      : super(const GetAllArticlesState.initial());

  Future<void> all() async {
    state = const GetAllArticlesState.loading();
    final fos = await _repository.getAllArticles();
    state = fos.fold(
      (l) => GetAllArticlesState.error(l),
      (r) => r.when(
        noConnection: () => const GetAllArticlesState.noConnection(),
        result: (result) => result.isEmpty
            ? const GetAllArticlesState.empty()
            : GetAllArticlesState.success(result),
      ),
    );
  }
}
