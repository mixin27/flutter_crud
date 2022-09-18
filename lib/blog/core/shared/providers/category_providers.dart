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

final sortedCategoryListProvider = StateProvider<List<CategoryModel>>(
  (ref) => ref.watch(getAllCategoriesNotifierProvider).maybeWhen(
        orElse: () => [],
        success: (categories) {
          List<CategoryModel> items = [...categories];
          items.sort((a, b) => a.name.compareTo(b.name));
          return items;
        },
      ),
);

final categoryListProvider = StateProvider<List<CategoryModel>>(
  (ref) {
    List<CategoryModel> sortedCategories =
        ref.watch(sortedCategoryListProvider);
    const all = CategoryModel(
      id: '',
      name: 'All News',
      createdAt: '',
      createdBy: '',
      updatedAt: '',
      updatedBy: '',
      active: true,
    );
    sortedCategories.sort((a, b) => a.name.compareTo(b.name));
    sortedCategories = [all, ...sortedCategories];
    return sortedCategories;
  },
);

final allNewsCategoryProvider = Provider<CategoryModel>(
  (ref) => ref.watch(categoryListProvider).first,
);

final selectedCategoryProvider = StateProvider<CategoryModel?>(
  (ref) => null,
);
