import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class PostListItem extends ConsumerWidget {
  const PostListItem({
    Key? key,
    required this.post,
    this.mine = false,
  }) : super(key: key);

  final PostModel post;
  final bool mine;

  void showDeleteConfirmDialog(
      BuildContext context, PostModel post, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AppDialogBox(
        header: Text(
          AppStrings.deleteArticle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to delete this article?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(AppStrings.cancel),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                ref
                    .read(deletePostNotifierProvider.notifier)
                    .deletePost(id: post.id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              child: const Text(AppStrings.delete),
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AppDialogBox(
        header: Text(
          AppStrings.deleteArticle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<DeletePostState>(
      deletePostNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          success: (_) {
            ref.read(getPostsByUserNotifierProvider.notifier).getPosts();
          },
          noConnection: (_) {
            showMessage(context, AppStrings.connectionProblem);
          },
          error: (_) {
            showMessage(context, _.failure.message ?? AppStrings.unknownError);
          },
        );
      },
    );

    return InkWell(
      onTap: () {
        context.router.push(PostDetailRoute(postId: post.id));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.categoryName.isNotEmpty)
                    Text(
                      post.categoryName,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    post.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(90),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        post.author,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.date.toFormattedDateTime(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            if (mine)
              IconButton(
                onPressed: () {
                  showDeleteConfirmDialog(context, post, ref);
                },
                icon: const Icon(Icons.delete),
              ),
            // const Expanded(
            //   child: ClipRRect(
            //     clipBehavior: Clip.antiAliasWithSaveLayer,
            //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //     child: CommonCachedNetworkImage(
            //       url: 'assets/images/nb_sportsImage1.jpg',
            //       height: 100,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
