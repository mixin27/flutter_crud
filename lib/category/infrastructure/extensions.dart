import 'package:flutter_crud/category/feat_category.dart';

extension CategoryDtoListX on List<CategoryDto> {
  List<CategoryModel> get domainList => toDomainList();
  List<CategoryModel> toDomainList() => map((e) => e.domainModel).toList();
}
