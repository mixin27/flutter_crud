import 'package:dio/dio.dart';
import 'package:flutter_crud/auth/feat_auth.dart';

class AuthInterceptor extends Interceptor {
  final UserAuthenticator _authenticator;
  final AuthNotifier _authNotifier;
  final Dio _dio;

  AuthInterceptor(this._authenticator, this._authNotifier, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credential = await _authenticator.getSignedInCredential();
    final modifiedOptions = options
      ..headers.addAll(
        credential == null
            ? {}
            : {
                'Authorization': 'bearer ${credential.token}',
              },
      );

    handler.next(modifiedOptions);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;
    if (errorResponse != null && errorResponse.statusCode == 401) {
      final credentials = await _authenticator.getSignedInCredential();

      // credentials != null && credentials.canRefresh
      //     ? await _authenticator.refresh(credentials)
      //     : await _authenticator.clearCredentialsStorage();
      if (credentials != null) {
        await _authenticator.clearCredentialsStorage();
      }
      await _authNotifier.checkAndUpdateAuthStatus();
      final refreshCredentials = await _authenticator.getSignedInCredential();
      if (refreshCredentials != null) {
        handler.resolve(
          await _dio.fetch(
            errorResponse.requestOptions
              ..headers['Authorization'] = 'bearer ${refreshCredentials.token}',
          ),
        );
      }
    } else {
      handler.next(err);
    }
  }
}
