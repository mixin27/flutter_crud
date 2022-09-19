import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'update_post_notifier.freezed.dart';

@freezed
class UpdatePostState with _$UpdatePostState {
  const factory UpdatePostState.initial() = _Initial;
  const factory UpdatePostState.loading() = _Loading;
  const factory UpdatePostState.noConnection() = _NoConnection;
  const factory UpdatePostState.success(PostModel post) = _Success;
  const factory UpdatePostState.error(BlogFailure failure) = _Error;
}

class UpdatePostNotifier extends StateNotifier<UpdatePostState> {
  final PostRepository _repository;

  UpdatePostNotifier(this._repository) : super(const UpdatePostState.initial());

  Future<void> updatePost({
    required String id,
    required String title,
    required String content,
    required String status,
    required String categoryId,
  }) async {
    state = const UpdatePostState.loading();

    final failureOrSuccess = await _repository.updatePost(
      id: id,
      title: title,
      content: content,
      status: status,
      categoryId: categoryId,
    );

    state = failureOrSuccess.fold(
      (l) => UpdatePostState.error(l),
      (r) => r.when(
        noConnection: () => const UpdatePostState.noConnection(),
        result: (post) => UpdatePostState.success(post),
      ),
    );
  }
}
