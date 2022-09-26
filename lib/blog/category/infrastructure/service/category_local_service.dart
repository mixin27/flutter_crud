import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:sembast/sembast.dart';
import 'package:collection/collection.dart';
import 'package:smf_core/smf_core.dart';

class CategoryLocalService {
  final SembastDatabase _database;

  static const String tag = 'CategoryRemoteService';
  final _store = intMapStoreFactory.store('blog_categories');

  CategoryLocalService(this._database);

  /// Insert or update categories.
  Future<void> upsert(List<CategoryDto> dtos) async {
    await _store
        .records(dtos.mapIndexed((index, _) => index))
        .put(_database.instance, dtos.map((e) => e.toJson()).toList());
  }

  /// Get all categories
  Future<List<CategoryDto>> getAll() async {
    final records = await _store.find(_database.instance);
    return records.map((e) => CategoryDto.fromJson(e.value)).toList();
  }

  /// Delete all categories
  Future<void> deleteAll() async {
    final result = await _store.delete(_database.instance);
    Logger.clap(tag, 'Deleting categories affect $result rows');
  }
}
