import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

class BlogHelpers {
  static const String tag = 'BlogHelpers';

  static CategoryModel? getCategory(
    String id,
    List<CategoryModel> categories,
  ) {
    try {
      final item = categories.firstWhere((element) => element.id == id);
      return item;
    } on StateError catch (e) {
      Logger.e(tag, 'Error: $e');
      return null;
    }
  }
}
