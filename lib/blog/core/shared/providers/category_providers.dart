import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryRemoteServiceProvider = Provider(
  (ref) => CategoryRemoteService(
    ref.watch(dioProvider),
  ),
);

final categoryLocalServiceProvider = Provider(
  (ref) => CategoryLocalService(),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    ref.watch(categoryRemoteServiceProvider),
  ),
);

final getAllCategoriesNotifierProvider =
    StateNotifierProvider<GetAllCagetoriesNotifier, GetAllCategoriesState>(
  (ref) => GetAllCagetoriesNotifier(
    ref.watch(categoryRepositoryProvider),
  ),
);

final createCategoryNotifierProvider =
    StateNotifierProvider<CreateCategoryNotifier, CreateCategoryState>(
  (ref) => CreateCategoryNotifier(
    ref.watch(categoryRepositoryProvider),
  ),
);

final createLoadingProvider = StateProvider<bool>(
  (ref) => ref.watch(createCategoryNotifierProvider).maybeWhen(
        orElse: () => false,
        loading: () => true,
      ),
);

final categoryListProvider = StateProvider<List<CategoryModel>>(
  (ref) => ref.watch(getAllCategoriesNotifierProvider).maybeWhen(
        orElse: () => [],
        success: (categories) {
          final items = [...categories];
          items.sort((a, b) => a.name.compareTo(b.name));
          return items;
        },
      ),
);