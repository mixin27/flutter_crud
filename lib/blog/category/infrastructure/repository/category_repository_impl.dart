import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/category/feat_category.dart';
import 'package:flutter_crud/blog/core/domain/blog_failure.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteService _remoteService;

  CategoryRepositoryImpl(this._remoteService);

  @override
  Future<Either<BlogFailure, DomainResult<CategoryModel>>> createCategory(
      {required String name}) async {
    try {
      final result = await _remoteService.createCategory(name: name);

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
  Future<Either<BlogFailure, DomainResult<List<CategoryModel>>>>
      getAllCategories() async {
    try {
      final result = await _remoteService.getAllCategories();

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (data) => DomainResult.result(data.domainList),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }
}
