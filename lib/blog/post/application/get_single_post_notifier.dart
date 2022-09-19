import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_single_post_notifier.freezed.dart';

@freezed
class GetSinglePostState with _$GetSinglePostState {
  const factory GetSinglePostState.initial() = _Initial;
  const factory GetSinglePostState.loading() = _Loading;
  const factory GetSinglePostState.noConnection() = _NoConnection;
  const factory GetSinglePostState.success(PostModel post) = _Success;
  const factory GetSinglePostState.error(BlogFailure failure) = _Error;
}

class GetSinglePostNotifier extends StateNotifier<GetSinglePostState> {
  final PostRepository _repository;

  GetSinglePostNotifier(this._repository)
      : super(const GetSinglePostState.initial());

  Future<void> getPostById({
    required String id,
  }) async {
    state = const GetSinglePostState.loading();

    final failureOrSuccess = await _repository.getPostById(id);
    state = failureOrSuccess.fold(
      (l) => GetSinglePostState.error(l),
      (r) => r.when(
        noConnection: () => const GetSinglePostState.noConnection(),
        result: (post) => GetSinglePostState.success(post),
      ),
    );
  }
}
