import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPostsPage extends ConsumerStatefulWidget {
  const UserPostsPage({super.key});

  @override
  _UserPostsPageState createState() => _UserPostsPageState();
}

class _UserPostsPageState extends ConsumerState<UserPostsPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    getUserArticles();
  }

  Future<void> getUserArticles() async {
    Future.microtask(
        () => ref.read(getPostsByUserNotifierProvider.notifier).getPosts());
  }

  @override
  Widget build(BuildContext context) {
    final userPostsState = ref.watch(getPostsByUserNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: const Text('Your Articles'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: userPostsState.map(
          initial: (_) => const SizedBox(),
          loading: (_) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          noConnection: (_) => ErrorPlaceholderWidget(
            message: AppStrings.connectionProblem,
            icon: Icons.wifi_off,
            onPressed: getUserArticles,
          ),
          empty: (_) => const ErrorPlaceholderWidget(
            message: 'No articles found',
            icon: Icons.newspaper_outlined,
          ),
          success: (_) => RefreshIndicator(
            onRefresh: getUserArticles,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                final post = _.posts.elementAt(index);
                return PostListItem(post: post, mine: true);
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _.posts.length,
            ),
          ),
          error: (_) => ErrorPlaceholderWidget(
            message: _.failure.message ?? AppStrings.unknownError,
            icon: Icons.newspaper_outlined,
            onPressed: getUserArticles,
          ),
        ),
      ),
    );
  }
}
