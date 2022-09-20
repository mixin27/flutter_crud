import 'package:flutter_crud/account/feat_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'change_password_notifier.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.loading() = _Loading;
  const factory ChangePasswordState.noConnection() = _NoConnection;
  const factory ChangePasswordState.success(UserModel user) = _Success;
  const factory ChangePasswordState.error(AccountFailure failure) = _Error;
}

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AccountRepository _repository;

  ChangePasswordNotifier(this._repository)
      : super(const ChangePasswordState.initial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    state = const ChangePasswordState.loading();

    final failureOrSuccess = await _repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    state = failureOrSuccess.fold(
      (l) => ChangePasswordState.error(l),
      (r) => r.when(
        noConnection: () => const ChangePasswordState.noConnection(),
        result: (user) => ChangePasswordState.success(user),
      ),
    );
  }
}
