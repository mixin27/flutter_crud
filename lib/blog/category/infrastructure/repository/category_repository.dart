import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

abstract class CategoryRepository {
  /// Get all categories.
  Future<Either<BlogFailure, DomainResult<List<CategoryModel>>>>
      getAllCategories();

  /// Create a category.
  Future<Either<BlogFailure, DomainResult<CategoryModel>>> createCategory(
      {required String name});
}
