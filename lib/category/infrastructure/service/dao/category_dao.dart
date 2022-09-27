import 'package:floor/floor.dart';
import 'package:flutter_crud/category/feat_category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM categories')
  Future<List<CategoryDto>> findAll();

  @Query('SELECT * FROM categories WHERE id = :id')
  Stream<CategoryDto?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOne(CategoryDto category);
}
