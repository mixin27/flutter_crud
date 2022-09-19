import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({
    super.key,
    @PathParam('id') required String postId,
  });

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    getSinglePost();
  }

  Future<void> getSinglePost() async {
    Future.microtask(() => ref
        .read(getSinglePostNotifierProvider.notifier)
        .getPostById(id: context.routeData.pathParams.getString('id')));
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(getSinglePostNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text('Article Detail'),
        actions: [
          postState.maybeMap(
            orElse: () => const SizedBox(),
            success: (_) => IconButton(
              onPressed: () {
                context.router.push(EditPostRoute(post: _.post));
              },
              icon: const Icon(Icons.edit_calendar_outlined),
            ),
          ),
        ],
      ),
      body: postState.map(
        initial: (_) => const SizedBox(),
        loading: (_) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        noConnection: (_) => ErrorPlaceholderWidget(
          message: AppStrings.connectionProblem,
          icon: Icons.wifi_off,
          onPressed: getSinglePost,
        ),
        success: (_) {
          final post = _.post;

          return RefreshIndicator(
            onRefresh: getSinglePost,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                if (post.categoryName.isNotEmpty) const SizedBox(height: 20),
                if (post.categoryName.isNotEmpty)
                  Text(
                    post.categoryName,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                const SizedBox(height: 20),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                        const SizedBox(width: 10),
                        Text(post.author),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Text(
                      post.date.toFormattedDateTime(),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  post.content,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          );
        },
        error: (_) => ErrorPlaceholderWidget(
          message: _.failure.message ?? AppStrings.unknownError,
          icon: Icons.newspaper,
          onPressed: getSinglePost,
        ),
      ),
    );
  }
}
