import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    required String userId,
    required String name,
    required String avatarUrl,
    required String description,
    required String phone,
    required String email,
    required String registerOn,
    required String createdAt,
    required String createdBy,
    required String updatedAt,
    required String updatedBy,
    required String lastLogin,
    required bool active,
  }) = _UserModel;
}
