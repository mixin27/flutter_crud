import 'package:json_annotation/json_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'response_dto.g.dart';

@JsonSerializable()
class ResponseDto {
  @JsonKey(name: 'code', fromJson: stringFromJson)
  final String code;
  @JsonKey(name: 'message', fromJson: stringFromJson)
  final String message;
  @JsonKey(name: 'data')
  final dynamic data;

  ResponseDto({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);

  ResponseDto copyWith({
    String? code,
    String? message,
    dynamic data,
  }) {
    return ResponseDto(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'ResponseDto(code: $code, message: $message, data: $data)';

  @override
  bool operator ==(covariant ResponseDto other) {
    if (identical(this, other)) return true;

    return other.code == code && other.message == message && other.data == data;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}
