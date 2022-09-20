import 'package:dartz/dartz.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:smf_core/smf_core.dart';

abstract class AccountRepository {
  /// Get profile
  Future<Either<AccountFailure, DomainResult<UserModel>>> getProfile();

  /// Update profile
  Future<Either<AccountFailure, DomainResult<UserModel>>> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String description,
  });

  /// Change password
  Future<Either<AccountFailure, DomainResult<UserModel>>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
