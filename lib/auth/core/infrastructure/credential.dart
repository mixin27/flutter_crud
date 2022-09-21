import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  @JsonKey(name: 'token')
  final String accessToken;
  @JsonKey(name: 'type')
  final String type;

  Credential({
    required this.accessToken,
    required this.type,
  });

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialToJson(this);

  Credential copyWith({
    String? accessToken,
    String? type,
  }) {
    return Credential(
      accessToken: accessToken ?? this.accessToken,
      type: type ?? this.type,
    );
  }

  @override
  String toString() => 'Credential(accessToken: $accessToken, type: $type)';

  @override
  bool operator ==(covariant Credential other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.type == type;
  }

  @override
  int get hashCode => accessToken.hashCode ^ type.hashCode;
}
