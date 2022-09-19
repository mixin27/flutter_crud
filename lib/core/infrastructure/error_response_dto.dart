import 'package:json_annotation/json_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'error_response_dto.g.dart';

@JsonSerializable()
class ErrorResponseDto {
  @JsonKey(name: 'code', fromJson: stringFromJson)
  final String code;
  @JsonKey(name: 'message', fromJson: stringFromJson)
  final String message;
  @JsonKey(name: 'description', fromJson: stringFromJson)
  final String description;

  ErrorResponseDto({
    required this.code,
    required this.message,
    required this.description,
  });

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseDtoToJson(this);

  ErrorResponseDto copyWith({
    String? code,
    String? message,
    String? description,
  }) {
    return ErrorResponseDto(
      code: code ?? this.code,
      message: message ?? this.message,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'description': description,
    };
  }

  factory ErrorResponseDto.fromMap(Map<String, dynamic> map) {
    return ErrorResponseDto(
      code: map['code'] as String,
      message: map['message'] as String,
      description: map['description'] as String,
    );
  }

  @override
  String toString() =>
      'ErrorResponseDto(code: $code, message: $message, description: $description)';

  @override
  bool operator ==(covariant ErrorResponseDto other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        other.description == description;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ description.hashCode;
}
