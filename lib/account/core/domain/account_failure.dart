import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_failure.freezed.dart';

@freezed
class AccountFailure with _$AccountFailure {
  const factory AccountFailure.api(
    int? errorCode,
    String? message,
  ) = _Api;
}
