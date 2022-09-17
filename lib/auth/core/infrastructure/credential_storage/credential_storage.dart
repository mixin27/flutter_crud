import 'package:flutter_crud/auth/feat_auth.dart';

/// Credential storage interface.
abstract class CredentialStorage {
  Future<Credential?> read();
  Future<void> save(Credential credential);
  Future<void> clear();
}
