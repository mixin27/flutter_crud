import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:smf_core/smf_core.dart';

/// Database for local caching.
class SembastDatabase {
  static const String tag = 'SembastDatabase';

  late Database _instance;
  Database get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    Logger.clap(tag, 'Initialize sembast database...');

    if (_hasBeenInitialized) {
      Logger.clap(tag, 'Sembast database is already initialized.');
      return;
    }
    _hasBeenInitialized = true;

    final dbDirectory = await getApplicationDocumentsDirectory();
    dbDirectory.create(recursive: true);

    final dbPath = join(dbDirectory.path, 'news_blog.sembast');
    _instance = await databaseFactoryIo.openDatabase(dbPath);

    Logger.clap(
      tag,
      'Initialized sembast database success at ${_instance.path}',
    );
  }
}
