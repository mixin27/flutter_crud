import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'delete_post_notifier.freezed.dart';

@freezed
class DeletePostState with _$DeletePostState {
  const factory DeletePostState.initial() = _Initial;
  const factory DeletePostState.loading() = _Loading;
  const factory DeletePostState.noConnection() = _NoConnection;
  const factory DeletePostState.success() = _Success;
  const factory DeletePostState.error(BlogFailure failure) = _Error;
}

class DeletePostNotifier extends StateNotifier<DeletePostState> {
  final PostRepository _repository;

  DeletePostNotifier(this._repository) : super(const DeletePostState.initial());

  Future<void> deletePost({
    required String id,
  }) async {
    state = const DeletePostState.loading();

    final failureOrSuccess = await _repository.deletePost(id: id);
    state = failureOrSuccess.fold(
      (l) => DeletePostState.error(l),
      (r) => r.when(
        noConnection: () => const DeletePostState.noConnection(),
        result: (_) => const DeletePostState.success(),
      ),
    );
  }
}
