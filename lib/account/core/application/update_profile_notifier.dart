import 'package:flutter_crud/account/feat_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'update_profile_notifier.freezed.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;
  const factory UpdateProfileState.loading() = _Loading;
  const factory UpdateProfileState.noConnection() = _NoConnection;
  const factory UpdateProfileState.success(UserModel user) = _Success;
  const factory UpdateProfileState.error(AccountFailure failure) = _Error;
}

class UpdateProfileNotifier extends StateNotifier<UpdateProfileState> {
  final AccountRepository _repository;

  UpdateProfileNotifier(this._repository)
      : super(const UpdateProfileState.initial());

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String description,
  }) async {
    state = const UpdateProfileState.loading();

    final failureOrSuccess = await _repository.updateProfile(
      name: name,
      email: email,
      phone: phone,
      description: description,
    );

    state = failureOrSuccess.fold(
      (l) => UpdateProfileState.error(l),
      (r) => r.when(
        noConnection: () => const UpdateProfileState.noConnection(),
        result: (user) => UpdateProfileState.success(user),
      ),
    );
  }
}
