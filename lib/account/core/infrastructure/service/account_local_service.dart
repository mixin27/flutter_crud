import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:sembast/sembast.dart';
import 'package:smf_core/smf_core.dart';

class AccountLocalService {
  static const String tag = 'AccountLocalService';

  final SembastDatabase _database;
  final _userStore = intMapStoreFactory.store('blog_user');

  AccountLocalService(this._database);

  /// Insert or update user data.
  Future<void> upsertUser(UserDto dto) async {
    await _userStore.record(0).put(_database.instance, dto.toJson());
  }

  /// Get user.
  Future<UserDto?> getUser() async {
    final user = _userStore.record(0);
    final userSnapshot = await user.getSnapshot(_database.instance);

    if (userSnapshot == null) {
      return null;
    }
    return UserDto.fromJson(userSnapshot.value);
  }

  /// Delete user store.
  Future<void> deleteUserStore() async {
    Logger.d(tag, 'Deleting user store');
    final result = await _userStore.delete(_database.instance);
    Logger.clap(tag, 'Deleting success with $result');
  }
}
