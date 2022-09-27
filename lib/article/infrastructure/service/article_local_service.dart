import 'package:flutter_crud/article/feat_article.dart';

class ArticleLocalService {
  final ArticleDao _dao;

  ArticleLocalService(this._dao);

  Future<List<ArticleDto>> getAllArticles() async {
    return await _dao.findAll();
  }

  Future<ArticleDto?> getArticleById(String id) async {
    return await _dao.findById(id);
  }

  Future<void> addOne(ArticleDto article) async {
    await _dao.insertOne(article);
  }

  Future<List<int>> addAll(List<ArticleDto> articles) async {
    return await _dao.insertMany(articles);
  }
}
