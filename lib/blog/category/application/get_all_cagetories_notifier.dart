import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_all_cagetories_notifier.freezed.dart';

@freezed
class GetAllCategoriesState with _$GetAllCategoriesState {
  const factory GetAllCategoriesState.initial() = _Initial;
  const factory GetAllCategoriesState.loading() = _Loading;
  const factory GetAllCategoriesState.empty() = _Empty;
  const factory GetAllCategoriesState.noConnection() = _NoConnection;
  const factory GetAllCategoriesState.success(
    List<CategoryModel> categories,
  ) = _Success;
  const factory GetAllCategoriesState.error(BlogFailure failure) = _Error;
}

class GetAllCagetoriesNotifier extends StateNotifier<GetAllCategoriesState> {
  final CategoryRepository _repository;

  GetAllCagetoriesNotifier(this._repository)
      : super(const GetAllCategoriesState.initial());

  Future<void> getAllCategories() async {
    state = const GetAllCategoriesState.loading();

    final failureOrSuccess = await _repository.getAllCategories();

    state = failureOrSuccess.fold(
      (l) => GetAllCategoriesState.error(l),
      (r) => r.when(
        noConnection: () => const GetAllCategoriesState.noConnection(),
        result: (res) => res.isEmpty
            ? const GetAllCategoriesState.empty()
            : GetAllCategoriesState.success(res),
      ),
    );
  }
}
