import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'delete_multi_post_notifier.freezed.dart';

@freezed
class DeleteMultiPostState with _$DeleteMultiPostState {
  const factory DeleteMultiPostState.initial() = _Initial;
  const factory DeleteMultiPostState.loading() = _Loading;
  const factory DeleteMultiPostState.noConnection() = _NoConnection;
  const factory DeleteMultiPostState.success() = _Success;
  const factory DeleteMultiPostState.error(BlogFailure failure) = _Error;
}

class DeleteMultiPostNotifier extends StateNotifier<DeleteMultiPostState> {
  final PostRepository _repository;

  DeleteMultiPostNotifier(this._repository)
      : super(const DeleteMultiPostState.initial());

  Future<void> deletePosts(List<String> ids) async {
    state = const DeleteMultiPostState.loading();

    final failureOrSuccess = await _repository.deleteMultiplePosts(ids: ids);
    state = failureOrSuccess.fold(
      (l) => DeleteMultiPostState.error(l),
      (r) => r.when(
        noConnection: () => const DeleteMultiPostState.noConnection(),
        result: (_) => const DeleteMultiPostState.success(),
      ),
    );
  }
}
