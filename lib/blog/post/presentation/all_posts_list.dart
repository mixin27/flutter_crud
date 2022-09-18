import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/post_list_item.dart';

class AllPostsList extends ConsumerStatefulWidget {
  const AllPostsList({super.key});

  @override
  _AllPostsListState createState() => _AllPostsListState();
}

class _AllPostsListState extends ConsumerState<AllPostsList> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    Future.microtask(
        () => ref.read(getAllPostsNotifierProvider.notifier).getFirstPage());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final allPostsState = ref.watch(getAllPostsNotifierProvider);

    return allPostsState.map(
      initial: (_) => const SizedBox(),
      loading: (_) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      noConnection: (_) => ErrorPlaceholderWidget(
        message: AppStrings.connectionProblem,
        icon: Icons.wifi_off,
        onPressed: getAllPosts,
      ),
      empty: (_) => const ErrorPlaceholderWidget(icon: Icons.newspaper),
      success: (_) => RefreshIndicator(
        onRefresh: getAllPosts,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          itemCount: _.posts.entity.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final post = _.posts.entity.elementAt(index);
            return PostListItem(post: post);
          },
        ),
      ),
      error: (_) => ErrorPlaceholderWidget(
        message: _.failure.message ?? AppStrings.unknownError,
        onPressed: getAllPosts,
      ),
    );
  }
}
