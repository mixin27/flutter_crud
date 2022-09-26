import 'dart:convert';

import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smf_core/smf_core.dart' hide Credential;

class SecureCredentialStorage implements CredentialStorage {
  final FlutterSecureStorage _storage;

  SecureCredentialStorage(this._storage);

  static const String tag = 'SecureCredentialStorage';
  static const String _key = 'auth_credential';
  Credential? _cachedCredential;

  @override
  Future<Credential?> read() async {
    if (_cachedCredential != null) {
      return _cachedCredential;
    }

    final result = await _storage.read(key: _key);
    if (result == null) {
      return null;
    }

    final json = jsonDecode(result);
    try {
      return _cachedCredential = Credential.fromJson(json);
    } on FormatException catch (e) {
      Logger.e(tag, 'FormatException: ${e.message}');
      return null;
    }
  }

  @override
  Future<void> save(Credential credential) async {
    _cachedCredential = credential;
    return _storage.write(
      key: _key,
      value: jsonEncode(credential.toJson()),
    );
  }

  @override
  Future<void> clear() {
    _cachedCredential = null;
    return _storage.delete(key: _key);
  }
}
