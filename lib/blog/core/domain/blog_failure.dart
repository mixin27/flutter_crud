import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_failure.freezed.dart';

@freezed
class BlogFailure with _$BlogFailure {
  const factory BlogFailure.api(
    int? errorCode,
    String? message,
  ) = _Api;
}
