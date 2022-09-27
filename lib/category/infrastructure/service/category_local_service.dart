import 'package:flutter_crud/category/feat_category.dart';

class CategoryLocalService {
  final CategoryDao _dao;

  CategoryLocalService(this._dao);

  Future<List<CategoryDto>> getAllCategories() async {
    return await _dao.findAll();
  }

  Future<CategoryDto?> getCategoryById(String id) async {
    return await _dao.findById(id);
  }

  Future<void> addOne(CategoryDto category) async {
    await _dao.insertOne(category);
  }

  Future<List<int>> addAll(List<CategoryDto> categories) async {
    return await _dao.insertMany(categories);
  }
}
