import 'package:dartz/dartz.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:smf_core/smf_core.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteService _remoteService;
  final AccountLocalService _localService;

  AccountRepositoryImpl(this._remoteService, this._localService);

  @override
  Future<Either<AccountFailure, DomainResult<UserModel>>> getProfile() async {
    try {
      final result = await _remoteService.getUserProfile();

      return right(
        await result.when(
          noConnection: () async {
            final localItem = await _localService.getUser();
            if (localItem == null) return const DomainResult.noConnection();
            return DomainResult.result(localItem.domainModel);
          },
          withData: (user) async {
            await _localService.upsertUser(user);
            return DomainResult.result(user.domainModel);
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(AccountFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<AccountFailure, DomainResult<UserModel>>> updateProfile(
      {required String name,
      required String email,
      required String phone,
      required String description}) async {
    try {
      final result = await _remoteService.updateUserProfile(
        name: name,
        email: email,
        phone: phone,
        description: description,
      );

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (user) => DomainResult.result(user.domainModel),
        ),
      );
    } on RestApiException catch (e) {
      return left(AccountFailure.api(e.errorCode, e.message));
    }
  }

  @override
  Future<Either<AccountFailure, DomainResult<UserModel>>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final result = await _remoteService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      return right(
        await result.when(
          noConnection: () => const DomainResult.noConnection(),
          withData: (user) => DomainResult.result(user.domainModel),
        ),
      );
    } on RestApiException catch (e) {
      return left(AccountFailure.api(e.errorCode, e.message));
    }
  }
}
