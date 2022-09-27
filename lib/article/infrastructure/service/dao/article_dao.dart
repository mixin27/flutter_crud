import 'package:floor/floor.dart';
import 'package:flutter_crud/article/feat_article.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM articles')
  Future<List<ArticleDto>> findAll();

  @Query('SELECT * FROM articles')
  Stream<List<ArticleDto>> findAllStream();

  @Query('SELECT * FROM articles WHERE id = :id')
  Future<ArticleDto?> findById(String id);

  @Query('SELECT * FROM articles WHERE id = :id')
  Stream<ArticleDto?> findByIdStream(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOne(ArticleDto article);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertMany(List<ArticleDto> articles);

  @Query("delete from articles where id = :id")
  Future<void> deleteById(int id);

  @delete
  Future<int> deleteAll(List<ArticleDto> articles);
}
