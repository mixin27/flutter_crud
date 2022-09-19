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

  /// Update the category by id.

  Future<Either<BlogFailure, DomainResult<CategoryModel>>> updateCategory(
      {required String id, required String name});

  /// Delete the category by id.
  Future<Either<BlogFailure, DomainResult<Unit>>> deleteCategory(
      {required String id});
}
