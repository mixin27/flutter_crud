import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_result.freezed.dart';

@freezed
class PaginatedResult<T> with _$PaginatedResult<T> {
  const PaginatedResult._();
  const factory PaginatedResult({
    required T entity,
    bool? isNextPageAvailable,
    @Default(false) bool isNoConnection,
  }) = _PaginatedResult<T>;
}
