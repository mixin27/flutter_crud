import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteService _remoteService;

  PostRepositoryImpl(this._remoteService);

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
          noConnection: () => const DomainResult.noConnection(),
          withData: (post) => DomainResult.result(post.domainModel),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<BlogFailure, PaginatedResult<List<PostModel>>>> getAllPosts(
      PostRequestParam param) async {
    try {
      final result = await _remoteService.getAllPosts(
        param: PostRequestParamDto.fromDomain(param),
      );

      return right(
        await result.when(
          noConnection: () => const PaginatedResult(
            entity: [],
            isNextPageAvailable: true,
          ),
          withData: (_) => PaginatedResult(
            entity: _.posts.domainList,
            isNextPageAvailable: _.page < _.total,
          ),
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
}
