import 'package:dartz/dartz.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  static const String tag = 'CategoryRepositoryImpl';

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
            final localItems = await _localService.getAllCategories();
            if (localItems.isEmpty) return const DomainResult.noConnection();
            return DomainResult.result(localItems.domainList);
          },
          withData: (data) async {
            final effectRows = await _localService.addAll(data);
            Logger.clap(tag, 'Inserted $effectRows categories.');
            return DomainResult.result(data.domainList);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(CategoryFailure.api(e.errorCode, e.message));
    }
  }
}
