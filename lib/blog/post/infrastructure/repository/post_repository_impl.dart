import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteService _remoteService;
  final PostLocalService _localService;

  PostRepositoryImpl(this._remoteService, this._localService);

  @override
  Future<Either<BlogFailure, DomainResult<PostModel>>> createPost(
      {required String title,
      required String content,
      required String status,
      required String categoryId}) async {
    try {
      final result = await _remoteService.createPost(
        title: title,
        content: content,
        status: status,
        categoryId: categoryId,
      );

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (data) => DomainResult.result(data.domainModel),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, DomainResult<PostModel>>> getPostById(
      String id) async {
    try {
      final result = await _remoteService.getPostById(id: id);

      return right(
        await result.when(
          noConnection: () async {
            final localItem = await _localService.getPostDetail(id);
            if (localItem == null) return const DomainResult.noConnection();
            return DomainResult.result(localItem.domainModel);
          },
          withData: (post) async {
            await _localService.upsertPostDetail(post);
            return DomainResult.result(post.domainModel);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, PaginatedResult<List<PostModel>>>> getAllPosts(
      PostRequestParam param) async {
    final page = param.pageNo ?? 0;
    try {
      final result = await _remoteService.getAllPosts(
        param: PostRequestParamDto.fromDomain(param),
      );

      return right(
        await result.when(
          noConnection: () async {
            final localItems = await _localService.getPage(page);
            return PaginatedResult(
              entity: localItems.domainList,
              isNextPageAvailable:
                  (page + 1) < await _localService.getLocalPageCount(),
            );
          },
          withData: (_) async {
            await _localService.upsertPage(_.posts, page);
            return PaginatedResult(
              entity: _.posts.domainList,
              isNextPageAvailable: (page + 1) < _.total,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, DomainResult<PostModel>>> updatePost(
      {required String id,
      required String title,
      required String content,
      required String status,
      required String categoryId}) async {
    try {
      final result = await _remoteService.updatePost(
        id: id,
        title: title,
        content: content,
        status: status,
        categoryId: categoryId,
      );

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (post) => DomainResult.result(post.domainModel),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, DomainResult<Unit>>> deletePost(
      {required String id}) async {
    try {
      final result = await _remoteService.deletePost(id: id);

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (res) => DomainResult.result(res),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, DomainResult<Unit>>> deleteMultiplePosts(
      {required List<String> ids}) async {
    try {
      final result = await _remoteService.deleteMultiplePosts(ids: ids);

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (res) => DomainResult.result(res),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, DomainResult<List<PostModel>>>>
      getAllPostsByUser() async {
    try {
      final result = await _remoteService.getAllPostsByUser();

      return right(
        await result.when(
          noConnection: () async {
            final localItems = await _localService.getUserPosts();
            if (localItems.isEmpty) return const DomainResult.noConnection();
            return DomainResult.result(localItems.domainList);
          },
          withData: (posts) async {
            await _localService.upsertUserPosts(posts);
            return DomainResult.result(posts.domainList);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }
}
