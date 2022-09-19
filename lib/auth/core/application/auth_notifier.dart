import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.inProgress() = _InProgress;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(
    AuthFailure failure,
  ) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final UserAuthenticator _authenticator;

  AuthNotifier(this._authenticator) : super(const AuthState.initial());

  /// check whether authenicated or unauthenticated and update the auth status.
  ///
  /// Set [AuthState] - [AuthState.authenticated()] or [AuthState.unauthenticated()]
  Future<void> checkAndUpdateAuthStatus() async {
    state = (await _authenticator.isSignedIn())
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  /// Sign in
  Future<void> signInWithEmailAnPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.inProgress();

    final failureOrSuccess = await _authenticator.signInWithEmailAnPassword(
      email: email,
      password: password,
    );

    state = failureOrSuccess.fold(
      (l) => AuthState.error(l),
      (r) => const AuthState.authenticated(),
    );
  }

  /// Sign up
  Future<void> createUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AuthState.inProgress();

    final failureOrSuccess = await _authenticator.createUser(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    state = failureOrSuccess.fold(
      (l) => AuthState.error(l),
      (r) => const AuthState.authenticated(),
    );
  }

  /// Sign out
  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();

    state = failureOrSuccess.fold(
      (l) => AuthState.error(l),
      (r) => const AuthState.unauthenticated(),
    );
  }
}
