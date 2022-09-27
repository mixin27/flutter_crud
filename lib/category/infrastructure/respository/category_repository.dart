import 'package:dartz/dartz.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:smf_core/smf_core.dart';

abstract class CategoryRepository {
  Future<Either<CategoryFailure, DomainResult<List<CategoryModel>>>>
      getAllCategories();
}
