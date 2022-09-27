import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_failure.freezed.dart';

@freezed
class ArticleFailure with _$ArticleFailure {
  const factory ArticleFailure.api(
    int? errorCode,
    String? message,
  ) = _Api;
}
