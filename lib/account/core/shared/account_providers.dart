import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountRemoteServiceProvider = Provider<AccountRemoteService>(
  (ref) => AccountRemoteService(
    ref.watch(dioProvider),
  ),
);

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(
    ref.watch(accountRemoteServiceProvider),
  ),
);

final getProfileNotifierProvider =
    StateNotifierProvider<GetProfileNotifier, GetProfileState>(
  (ref) => GetProfileNotifier(
    ref.watch(accountRepositoryProvider),
  ),
);

final updateProfileNotifierProvider =
    StateNotifierProvider<UpdateProfileNotifier, UpdateProfileState>(
  (ref) => UpdateProfileNotifier(
    ref.watch(accountRepositoryProvider),
  ),
);

final changePasswordNotifierProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
  (ref) => ChangePasswordNotifier(
    ref.watch(accountRepositoryProvider),
  ),
);
