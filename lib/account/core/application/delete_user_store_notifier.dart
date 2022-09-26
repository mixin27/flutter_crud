import 'package:flutter_crud/account/feat_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteUserStoreNotifier extends StateNotifier<AsyncValue<String>> {
  final AccountRepository _repository;

  DeleteUserStoreNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> deleteUserStore() async {
    _repository.deleteUserStore().then((value) {
      state = const AsyncValue.data('Success');
    }).onError((error, stackTrace) {
      state = AsyncValue.error(error ?? 'Failed to delete user store');
    });
  }
}
