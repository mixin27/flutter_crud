import 'package:flutter_crud/category/feat_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_all_categories_notifier.freezed.dart';

@freezed
class GetAllCategoriesState with _$GetAllCategoriesState {
  const factory GetAllCategoriesState.initial() = _Initial;
  const factory GetAllCategoriesState.loading() = _Loading;
  const factory GetAllCategoriesState.empty() = _Empty;
  const factory GetAllCategoriesState.noConnection() = _NoConnection;
  const factory GetAllCategoriesState.success(List<CategoryModel> categories) =
      _Success;
  const factory GetAllCategoriesState.error(CategoryFailure failure) = _Error;
}

class GetAllCategoriesNotifier extends StateNotifier<GetAllCategoriesState> {
  final CategoryRepository _repository;

  GetAllCategoriesNotifier(this._repository)
      : super(const GetAllCategoriesState.initial());

  Future<void> all() async {
    state = const GetAllCategoriesState.loading();

    final fos = await _repository.getAllCategories();
    state = fos.fold(
      (l) => GetAllCategoriesState.error(l),
      (r) => r.when(
        noConnection: () => const GetAllCategoriesState.noConnection(),
        result: (result) => result.isEmpty
            ? const GetAllCategoriesState.empty()
            : GetAllCategoriesState.success(result),
      ),
    );
  }
}
