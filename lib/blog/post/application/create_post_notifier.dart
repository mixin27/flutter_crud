import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'create_post_notifier.freezed.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.initial() = _Initial;
  const factory CreatePostState.loading() = _Loading;
  const factory CreatePostState.noConnection() = _NoConnection;
  const factory CreatePostState.success(PostModel post) = _Success;
  const factory CreatePostState.error(BlogFailure failure) = _Error;
}

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  final PostRepository _repository;

  CreatePostNotifier(this._repository) : super(const CreatePostState.initial());

  Future<void> createPost({
    required String title,
    required String content,
    required String status,
    required String categoryId,
  }) async {
    state = const CreatePostState.loading();

    final failureOrSuccess = await _repository.createPost(
      title: title,
      content: content,
      status: status,
      categoryId: categoryId,
    );

    state = failureOrSuccess.fold(
      (l) => CreatePostState.error(l),
      (r) => r.when(
        noConnection: () => const CreatePostState.noConnection(),
        result: (result) => CreatePostState.success(result),
      ),
    );
  }
}
