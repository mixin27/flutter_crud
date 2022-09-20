import 'package:flutter_crud/account/feat_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_profile_notifier.freezed.dart';

@freezed
class GetProfileState with _$GetProfileState {
  const factory GetProfileState.initial() = _Initial;
  const factory GetProfileState.loading() = _Loading;
  const factory GetProfileState.noConnection() = _NoConnection;
  const factory GetProfileState.success(UserModel user) = _Success;
  const factory GetProfileState.error(AccountFailure failure) = _Error;
}

class GetProfileNotifier extends StateNotifier<GetProfileState> {
  final AccountRepository _repository;

  GetProfileNotifier(this._repository) : super(const GetProfileState.initial());

  Future<void> getProfile() async {
    state = const GetProfileState.loading();

    final failureOrSuccess = await _repository.getProfile();
    state = failureOrSuccess.fold(
      (l) => GetProfileState.error(l),
      (r) => r.when(
        noConnection: () => const GetProfileState.noConnection(),
        result: (user) => GetProfileState.success(user),
      ),
    );
  }
}
