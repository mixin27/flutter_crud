import 'package:dio/dio.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:smf_core/smf_core.dart';

class AccountRemoteService {
  final Dio _dio;

  AccountRemoteService(this._dio);

  static const String tag = "AccountRemoteService";

  /// Get user profile.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<UserDto>> getUserProfile() async {
    try {
      final response = await _dio.get(AppConsts.apiEndpoints.user);

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData);
        final user = UserDto.fromJson(data.data);
        return Result.withData(user);
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const Result.noConnection();
      } else if (e.error != null) {
        throw RestApiException(
          e.response?.statusCode,
          e.response?.statusMessage,
        );
      } else {
        rethrow;
      }
    }
  }

  /// Update user profile.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<UserDto>> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        AppConsts.apiEndpoints.userUpdate,
        data: {
          "name": name,
          "email": email,
          "phoneNumber": phone,
          "description": description
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData);
        final user = UserDto.fromJson(data.data);
        return Result.withData(user);
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const Result.noConnection();
      } else if (e.error != null) {
        throw RestApiException(
          e.response?.statusCode,
          e.response?.statusMessage,
        );
      } else {
        rethrow;
      }
    }
  }

  /// Change password
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<UserDto>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppConsts.apiEndpoints.changePassword,
        data: {"oldPassword": oldPassword, "newPassword": newPassword},
      );

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData);
        final user = UserDto.fromJson(data.data);
        return Result.withData(user);
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const Result.noConnection();
      } else if (e.error != null) {
        throw RestApiException(
          e.response?.statusCode,
          e.response?.statusMessage,
        );
      } else {
        rethrow;
      }
    }
  }
}
