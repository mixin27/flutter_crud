import 'package:flutter/material.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class ArticleListPage extends HookConsumerWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> getArticles() async {
      Future.microtask(
        () => ref.read(getAllArticlesNotifierProvider.notifier).all(),
      );
    }

    useEffect(() {
      getArticles();
      return null;
    }, []);

    final articlesState = ref.watch(getAllArticlesNotifierProvider);

    return SizedBox(
      width: double.infinity,
      child: articlesState.map(
        initial: (_) => const SizedBox(),
        loading: (_) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        empty: (_) => const SmfErrorPlaceholder(
          message: 'No articles found',
          icon: Icons.newspaper,
        ),
        noConnection: (_) => SmfErrorPlaceholder(
          message: AppStrings.connectionProblem,
          icon: Icons.wifi_off,
          onPressed: getArticles,
        ),
        success: (_) => RefreshIndicator(
          onRefresh: getArticles,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              final article = _.articles.elementAt(index);
              return ListTile(
                onTap: () {},
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  article.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: _.articles.length,
          ),
        ),
        error: (_) => SmfErrorPlaceholder(
          message: _.failure.message ?? AppStrings.unknownError,
          icon: Icons.newspaper,
          onPressed: getArticles,
        ),
      ),
    );
  }
}
