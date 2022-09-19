import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'delete_category_notifier.freezed.dart';

@freezed
class DeleteCategoryState with _$DeleteCategoryState {
  const factory DeleteCategoryState.initial() = _Initial;
  const factory DeleteCategoryState.loading() = _Loading;
  const factory DeleteCategoryState.noConnection() = _NoConnection;
  const factory DeleteCategoryState.success() = _Success;
  const factory DeleteCategoryState.error(BlogFailure failure) = _Error;
}

class DeleteCategoryNotifier extends StateNotifier<DeleteCategoryState> {
  final CategoryRepository _repository;

  DeleteCategoryNotifier(this._repository)
      : super(const DeleteCategoryState.initial());

  Future<void> deleteCategoryById({
    required String id,
  }) async {
    state = const DeleteCategoryState.loading();

    final failureOrSuccess = await _repository.deleteCategory(id: id);

    state = failureOrSuccess.fold(
      (l) => DeleteCategoryState.error(l),
      (r) => r.when(
        noConnection: () => const DeleteCategoryState.noConnection(),
        result: (_) => const DeleteCategoryState.success(),
      ),
    );
  }
}
