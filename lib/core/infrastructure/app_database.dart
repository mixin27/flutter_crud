import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:smf_core/smf_core.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [CategoryDto])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
}

class AppFloorDB {
  static const String tag = 'AppFloorDB';

  late AppDatabase _instance;
  AppDatabase get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    Logger.d(tag, 'Initialize floor database...');

    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;

    _instance = await $FloorAppDatabase
        .databaseBuilder('news_blog.db')
        // .addMigrations([])
        .build();

    Logger.clap(tag, 'Initialization of floor database success.');
  }
}
