import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'update_category_notifier.freezed.dart';

@freezed
class UpdateCategoryState with _$UpdateCategoryState {
  const factory UpdateCategoryState.initial() = _Initial;
  const factory UpdateCategoryState.loading() = _Loading;
  const factory UpdateCategoryState.noConnection() = _NoConnection;
  const factory UpdateCategoryState.success(CategoryModel category) = _Success;
  const factory UpdateCategoryState.error(BlogFailure failure) = _Error;
}

class UpdateCategoryNotifier extends StateNotifier<UpdateCategoryState> {
  final CategoryRepository _repository;

  UpdateCategoryNotifier(this._repository)
      : super(const UpdateCategoryState.initial());

  Future<void> updateCategory({
    required String id,
    required String name,
  }) async {
    state = const UpdateCategoryState.loading();

    final failureOrSucess = await _repository.updateCategory(
      id: id,
      name: name,
    );

    state = failureOrSucess.fold(
      (l) => UpdateCategoryState.error(l),
      (r) => r.when(
        noConnection: () => const UpdateCategoryState.noConnection(),
        result: (result) => UpdateCategoryState.success(result),
      ),
    );
  }
}
