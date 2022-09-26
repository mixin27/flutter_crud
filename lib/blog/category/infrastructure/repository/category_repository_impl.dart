import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteService _remoteService;
  final CategoryLocalService _localService;

  CategoryRepositoryImpl(this._remoteService, this._localService);

  @override
  Future<Either<BlogFailure, DomainResult<List<CategoryModel>>>>
      getAllCategories() async {
    try {
      final result = await _remoteService.getAllCategories();

      return right(
        await result.when(
          noConnection: () async {
            final localItems = await _localService.getAll();
            return DomainResult.result(localItems.domainList);
          },
          withData: (data) async {
            await _localService.upsert(data);
            return DomainResult.result(data.domainList);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }

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
  Future<Either<BlogFailure, DomainResult<CategoryModel>>> updateCategory(
      {required String id, required String name}) async {
    try {
      final result = await _remoteService.updateCategory(id: id, name: name);

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
  Future<Either<BlogFailure, DomainResult<Unit>>> deleteCategory(
      {required String id}) async {
    try {
      final result = await _remoteService.deleteCategoryById(id: id);
      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (data) => DomainResult.result(data),
        ),
      );
    } on RestApiException catch (e) {
      return left(BlogFailure.api(e.errorCode, e.message));
    }
  }
}
