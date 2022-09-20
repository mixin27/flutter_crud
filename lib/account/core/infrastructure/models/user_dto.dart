import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();
  const factory UserDto({
    @JsonKey(name: 'UserID', fromJson: stringFromJson) required String userId,
    @JsonKey(name: 'Name', fromJson: stringFromJson) required String name,
    @JsonKey(name: 'Avatar', fromJson: stringFromJson)
        required String avatarUrl,
    @JsonKey(name: 'Description', fromJson: stringFromJson)
        required String description,
    @JsonKey(name: 'Phone', fromJson: stringFromJson) required String phone,
    @JsonKey(name: 'Email', fromJson: stringFromJson) required String email,
    @JsonKey(name: 'RegisteredOn', fromJson: stringFromJson)
        required String registerOn,
    @JsonKey(name: 'CreatedOn', fromJson: stringFromJson)
        required String createdAt,
    @JsonKey(name: 'CreatedBy', fromJson: stringFromJson)
        required String createdBy,
    @JsonKey(name: 'ModifiedOn', fromJson: stringFromJson)
        required String updatedAt,
    @JsonKey(name: 'ModifiedBy', fromJson: stringFromJson)
        required String updatedBy,
    @JsonKey(name: 'LastLogin', fromJson: stringFromJson)
        required String lastLogin,
    @JsonKey(name: 'Active', fromJson: boolFromJson) required bool active,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  UserModel get domainModel => toDomain();
  UserModel toDomain() => UserModel(
        userId: userId,
        name: name,
        avatarUrl: avatarUrl,
        description: description,
        phone: phone,
        email: email,
        registerOn: registerOn,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        lastLogin: lastLogin,
        active: active,
      );
}
