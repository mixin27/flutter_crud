import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postLocalServiceProvider = Provider(
  (ref) => PostLocalService(),
);

final postRemoteServiceProvider = Provider(
  (ref) => PostRemoteService(
    ref.watch(dioProvider),
  ),
);

final postRepositoryProvider = Provider<PostRepository>(
  (ref) => PostRepositoryImpl(
    ref.watch(postRemoteServiceProvider),
  ),
);

final createPostNotifierProvider =
    StateNotifierProvider<CreatePostNotifier, CreatePostState>(
  (ref) => CreatePostNotifier(
    ref.watch(postRepositoryProvider),
  ),
);

final getAllPostsNotifierProvider =
    StateNotifierProvider<GetAllPostsNotifier, GetAllPostsState>(
  (ref) => GetAllPostsNotifier(
    ref.watch(postRepositoryProvider),
  ),
);

final createPostLoading = StateProvider(
  (ref) => ref.watch(createPostNotifierProvider).maybeWhen(
        orElse: () => false,
        loading: () => true,
      ),
);
