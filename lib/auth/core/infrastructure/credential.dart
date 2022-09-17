import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  @JsonKey(name: 'token')
  final String token;

  Credential({
    required this.token,
  });

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialToJson(this);

  Credential copyWith({
    String? token,
  }) {
    return Credential(
      token: token ?? this.token,
    );
  }

  @override
  String toString() => 'Credential(token: $token)';

  @override
  bool operator ==(covariant Credential other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
