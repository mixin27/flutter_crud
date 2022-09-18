import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:smf_core/smf_core.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            const Expanded(
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: CommonCachedNetworkImage(
                  url: 'assets/images/nb_sportsImage1.jpg',
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
