import 'package:flutter_crud/blog/category/feat_category.dart';

extension ExtCategoryDtoList on List<CategoryDto> {
  List<CategoryModel> get domainList => toDomainList();
  List<CategoryModel> toDomainList() => map((e) => e.domainModel).toList();
}
