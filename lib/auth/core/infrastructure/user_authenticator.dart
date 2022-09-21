import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:smf_core/smf_core.dart';

class UserAuthenticator {
  // ignore: unused_field
  final Dio _dio;
  final CredentialStorage _credentialStorage;

  UserAuthenticator(this._dio, this._credentialStorage);

  static const String tag = 'UserAuthenticator';

  /// Get signed in credential from storage.
  ///
  /// Return [null] if there is no credential data in storage.
  Future<Credential?> getSignedInCredential() async {
    try {
      final storedCredential = await _credentialStorage.read();

      if (storedCredential != null) {
        // refresh token
      }

      return storedCredential;
    } on PlatformException {
      return null;
    }
  }

  /// Check whether the use is signed in or not.
  ///
  /// return [true] if signed in, return [false] if not.
  Future<bool> isSignedIn() =>
      getSignedInCredential().then((credential) => credential != null);

  /// Sign in user.
  /// If the user signed in successfully, save [Credential] data
  /// to [CredentialStorage].
  ///
  /// Return [AuthFailure] on the left and [Unit] on the right.
  Future<Either<AuthFailure, Unit>> signInWithEmailAnPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        "EmailOrPhone": email,
        "Password": password,
      };

      final response = await _dio.post(
        AppConsts.apiEndpoints.userLogin,
        data: payload,
        onSendProgress: (count, total) {
          Logger.d(tag, 'SendProgress: $count, $total');
        },
        onReceiveProgress: (count, total) {
          Logger.d(tag, 'ReceiveProgress: $count, $total');
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final result = ResponseDto.fromJson(jsonData);
        final credential = Credential(accessToken: result.data, type: 'Bearer');
        await _credentialStorage.save(credential);
        return right(unit);
      } else {
        return left(
          AuthFailure.server(
            '${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return left(
          AuthFailure.server(ApiUtils.messages.connectionProblem),
        );
      } else if (e.error != null) {
        Logger.e(tag, e.error);
        if (e.response == null) {
          return left(AuthFailure.server(ApiUtils.messages.unknownError));
        } else {
          return left(
            AuthFailure.server(
              '${e.error}: ${e.response?.statusMessage}',
            ),
          );
        }
      } else {
        Logger.e(tag, e);
        return left(AuthFailure.server(ApiUtils.messages.unknownError));
      }
    } on PlatformException catch (e) {
      Logger.e(tag, 'SignInWithEmailAndPasswordError: $e');
      return left(const AuthFailure.storage());
    }
  }

  /// Create user.
  /// If the user is created successfully, save [Credential] data
  /// to [CredentialStorage].
  ///
  /// Return [AuthFailure] on the left and [Unit] on the right.
  Future<Either<AuthFailure, Unit>> createUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final payload = {
        "Name": name,
        "Email": email,
        "PhoneNumber": phone,
        "Password": password,
      };

      final response = await _dio.post(
        AppConsts.apiEndpoints.userCreate,
        data: payload,
      );

      if (response.statusCode == AppConsts.status.created ||
          response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final result = ResponseDto.fromJson(jsonData);
        final credential = Credential(accessToken: result.data, type: 'Bearer');
        await _credentialStorage.save(credential);
        return right(unit);
      } else {
        return left(
          AuthFailure.server(
            '${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return left(
          AuthFailure.server(ApiUtils.messages.connectionProblem),
        );
      } else if (e.error != null) {
        Logger.e(tag, e.error);
        if (e.response == null) {
          return left(AuthFailure.server(ApiUtils.messages.unknownError));
        } else {
          return left(
            AuthFailure.server(
              '${e.error}: ${e.response?.statusMessage}',
            ),
          );
        }
      } else {
        Logger.e(tag, e);
        return left(AuthFailure.server(ApiUtils.messages.unknownError));
      }
    } on PlatformException catch (e) {
      Logger.e(tag, 'SignInWithEmailAndPasswordError: $e');
      return left(const AuthFailure.storage());
    }
  }

  /// Sign out user.
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      return clearCredentialsStorage();
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  /// Clear the cached credential.
  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
