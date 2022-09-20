import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_posts_by_user_notifier.freezed.dart';

@freezed
class GetPostsByUserState with _$GetPostsByUserState {
  const factory GetPostsByUserState.initial() = _Initial;
  const factory GetPostsByUserState.loading() = _Loading;
  const factory GetPostsByUserState.noConnection() = _NoConnection;
  const factory GetPostsByUserState.empty() = _Empty;
  const factory GetPostsByUserState.success(
    List<PostModel> posts,
  ) = _Success;
  const factory GetPostsByUserState.error(BlogFailure failure) = _Error;
}

class GetPostsByUserNotifier extends StateNotifier<GetPostsByUserState> {
  final PostRepository _repository;

  GetPostsByUserNotifier(this._repository)
      : super(const GetPostsByUserState.initial());

  Future<void> getPosts() async {
    state = const GetPostsByUserState.loading();

    final failureOrSuccess = await _repository.getAllPostsByUser();

    state = failureOrSuccess.fold(
      (l) => GetPostsByUserState.error(l),
      (r) => r.when(
        noConnection: () => const GetPostsByUserState.noConnection(),
        result: (res) => res.isEmpty
            ? const GetPostsByUserState.empty()
            : GetPostsByUserState.success(res),
      ),
    );
  }
}
