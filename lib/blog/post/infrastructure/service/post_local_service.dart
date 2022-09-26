import 'package:collection/collection.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:sembast/sembast.dart';

class PostLocalService {
  static const String tag = 'PostLocalService';
  final SembastDatabase _database;
  final _store = intMapStoreFactory.store('blog_articles');
  final _detailStore = stringMapStoreFactory.store('blog_article_detail');

  PostLocalService(this._database);

  /// Insert or update artilces with pagination.
  Future<void> upsertPage(
    List<PostDto> dtos,
    int page,
  ) async {
    final sembastPage = page - 1;

    await _store
        .records(dtos.mapIndexed(
          (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
        ))
        .put(_database.instance, dtos.map((e) => e.toJson()).toList());
  }

  Future<List<PostDto>> getPage(int page) async {
    final sembastPage = page - 1;

    final records = await _store.find(
      _database.instance,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: PaginationConfig.itemsPerPage * sembastPage,
      ),
    );

    return records.map((e) => PostDto.fromJson(e.value)).toList();
  }

  Future<int> getLocalPageCount() async {
    final postCount = await _store.count(_database.instance);
    return (postCount / PaginationConfig.itemsPerPage).ceil();
  }

  /// Insert or update post.
  Future<void> upsertPostDetail(PostDto dto) async {
    await _detailStore.record(dto.id).put(_database.instance, dto.toJson());
  }

  /// Get cached post.
  Future<PostDto?> getPostDetail(String id) async {
    final record = _detailStore.record(id);
    final recordSnapshot = await record.getSnapshot(_database.instance);

    if (recordSnapshot == null) {
      return null;
    }

    return PostDto.fromJson(recordSnapshot.value);
  }
}
