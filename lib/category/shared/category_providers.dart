import 'package:flutter_crud/category/feat_category.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryDaoProvider = Provider(
  (ref) => ref.watch(appFloorDBProvider).instance.categoryDao,
);

final categoryLocalService = Provider(
  (ref) => CategoryLocalService(
    ref.watch(categoryDaoProvider),
  ),
);

final categoryRemoteService = Provider(
  (ref) => CategoryRemoteService(
    ref.watch(dioProvider),
  ),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    ref.watch(categoryRemoteService),
    ref.watch(categoryLocalService),
  ),
);

final getAllCategoriesNotifierProvider =
    StateNotifierProvider<GetAllCategoriesNotifier, GetAllCategoriesState>(
  (ref) => GetAllCategoriesNotifier(
    ref.watch(categoryRepositoryProvider),
  ),
);

final categoryListProvider = StateProvider(
  (ref) => ref.watch(getAllCategoriesNotifierProvider).maybeWhen(
        orElse: () => [],
        success: (categories) => categories,
      ),
);
