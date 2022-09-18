import 'package:dio/dio.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:smf_core/smf_core.dart';

class AuthInterceptor extends Interceptor {
  final UserAuthenticator _authenticator;
  final AuthNotifier _authNotifier;
  final Dio _dio;

  AuthInterceptor(this._authenticator, this._authNotifier, this._dio);

  static const String tag = 'AuthInterceptor';

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
                'Authorization': 'Bearer ${credential.token}',
              },
      );

    Logger.clap(tag, 'RequestBody: ${modifiedOptions.data}');
    Logger.clap(tag, 'QueryParameters: ${modifiedOptions.queryParameters}');

    handler.next(modifiedOptions);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;
    Logger.e(tag, errorResponse);

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
              ..headers['Authorization'] = 'Bearer ${refreshCredentials.token}',
          ),
        );
      }
    } else {
      handler.next(err);
    }
  }
}
