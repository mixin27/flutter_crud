import 'package:dio/dio.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

final flutterSecureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);

final dioForAuthProvider = Provider(
  (ref) => Dio()
    ..options = BaseOptions(
      baseUrl: Env.uatBaseUrl,
      headers: {
        ApiUtils.keyAccept: ApiUtils.applicationJson,
        "apiKey": Env.apiKey,
      },
    ),
);

final authInterceptorProvider = Provider(
  (ref) => AuthInterceptor(
    ref.watch(userAuthenticatorProvider),
    ref.watch(authNotifierProvider.notifier),
    ref.watch(dioForAuthProvider),
  ),
);

final credentialStorageProvider = Provider<CredentialStorage>(
  (ref) => SecureCredentialStorage(
    ref.watch(flutterSecureStorageProvider),
  ),
);

final userAuthenticatorProvider = Provider(
  (ref) => UserAuthenticator(
    ref.watch(dioForAuthProvider),
    ref.watch(credentialStorageProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch(userAuthenticatorProvider),
  ),
);

final isSignInProvider = Provider<bool>(
  (ref) => ref.watch(authNotifierProvider).maybeWhen(
        orElse: () => false,
        authenticated: () => true,
      ),
);
