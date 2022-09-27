import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_failure.freezed.dart';

@freezed
class CategoryFailure with _$CategoryFailure {
  const factory CategoryFailure.api(
    int? errorCode,
    String? message,
  ) = _Api;
}
