import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'create_category_notifier.freezed.dart';

@freezed
class CreateCategoryState with _$CreateCategoryState {
  const factory CreateCategoryState.initial() = _Initial;
  const factory CreateCategoryState.loading() = _Loading;
  const factory CreateCategoryState.noConnection() = _NoConnection;
  const factory CreateCategoryState.success(
    CategoryModel category,
  ) = _Success;
  const factory CreateCategoryState.error(BlogFailure failure) = _Error;
}

class CreateCategoryNotifier extends StateNotifier<CreateCategoryState> {
  final CategoryRepository _repository;

  CreateCategoryNotifier(this._repository)
      : super(const CreateCategoryState.initial());

  Future<void> createCategory({
    required String name,
  }) async {
    state = const CreateCategoryState.loading();

    final failureOrSuccess = await _repository.createCategory(name: name);

    state = failureOrSuccess.fold(
      (l) => CreateCategoryState.error(l),
      (r) => r.when(
        noConnection: () => const CreateCategoryState.noConnection(),
        result: (res) => CreateCategoryState.success(res),
      ),
    );
  }
}
