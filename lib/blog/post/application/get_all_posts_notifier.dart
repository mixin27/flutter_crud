import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_all_posts_notifier.freezed.dart';

@freezed
class GetAllPostsState with _$GetAllPostsState {
  const factory GetAllPostsState.initial(
    PaginatedResult<List<PostModel>> posts,
  ) = _Initial;
  const factory GetAllPostsState.loading(
    PaginatedResult<List<PostModel>> posts,
  ) = _loading;
  const factory GetAllPostsState.noConnection(
    PaginatedResult<List<PostModel>> posts,
  ) = _noConnection;
  const factory GetAllPostsState.empty(
    PaginatedResult<List<PostModel>> posts,
  ) = _empty;
  const factory GetAllPostsState.success(
    PaginatedResult<List<PostModel>> posts, {
    required bool isNextPageAvailbale,
  }) = _Success;
  const factory GetAllPostsState.error(
    PaginatedResult<List<PostModel>> posts,
    BlogFailure failure,
  ) = _Error;
}

class GetAllPostsNotifier extends StateNotifier<GetAllPostsState> {
  final PostRepository _repository;

  GetAllPostsNotifier(this._repository)
      : super(const GetAllPostsState.initial(PaginatedResult(entity: [])));

  int _page = 0;

  @protected
  void resetState() {
    _page = 0;
    state = const GetAllPostsState.initial(PaginatedResult(entity: []));
  }

  Future<void> getFirstPage({
    String? categoryId,
    String? userId,
    String? status,
    String? searchText,
  }) async {
    resetState();
    await getNextPage(
      categoryId: categoryId,
      userId: userId,
      status: status,
      searchText: searchText,
    );
  }

  Future<void> getNextPage({
    String? categoryId,
    String? userId,
    String? status,
    String? searchText,
  }) async {
    state = GetAllPostsState.loading(state.posts);

    final requestParam = PostRequestParam(
      pageNo: _page,
      categoryId: categoryId,
      userId: userId,
      status: status,
      searchText: searchText,
    );

    final failureOrSuccess = await _repository.getAllPosts(requestParam);

    state = failureOrSuccess.fold(
      (l) => GetAllPostsState.error(state.posts, l),
      (r) {
        _page++;

        if (r.isNoConnection) {
          return GetAllPostsState.noConnection(state.posts);
        }

        if (r.entity.isEmpty) {
          return GetAllPostsState.empty(state.posts);
        }

        return GetAllPostsState.success(
          r.copyWith(
            entity: [...state.posts.entity, ...r.entity],
          ),
          isNextPageAvailbale: r.isNextPageAvailable ?? false,
        );
      },
    );
  }
}