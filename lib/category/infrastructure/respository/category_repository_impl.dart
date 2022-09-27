import 'package:dartz/dartz.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteService _remoteService;
  final CategoryLocalService _localService;

  CategoryRepositoryImpl(this._remoteService, this._localService);

  @override
  Future<Either<CategoryFailure, DomainResult<List<CategoryModel>>>>
      getAllCategories() async {
    try {
      final result = await _remoteService.getAllCategories();

      return right(
        await result.when(
          noConnection: () async {
            // todo: get from local cached
            return const DomainResult.noConnection();
          },
          withData: (data) {
            // todo: save to local cached
            return DomainResult.result(data.domainList);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(CategoryFailure.api(e.errorCode, e.message));
    }
  }
}
