import 'package:floor/floor.dart';
import 'package:flutter_crud/category/feat_category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM categories')
  Future<List<CategoryDto>> findAll();

  @Query('SELECT * FROM categories')
  Stream<List<CategoryDto>> findAllStream();

  @Query('SELECT * FROM categories WHERE id = :id')
  Future<CategoryDto?> findById(String id);

  @Query('SELECT * FROM categories WHERE id = :id')
  Stream<CategoryDto?> findByIdStream(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOne(CategoryDto category);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertMany(List<CategoryDto> categories);

  @Query("delete from categories where id = :id")
  Future<void> deleteById(int id);

  @delete
  Future<int> deleteAll(List<CategoryDto> categories);
}
