import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request_param.freezed.dart';

@freezed
class PostRequestParam with _$PostRequestParam {
  const PostRequestParam._();
  const factory PostRequestParam({
    @Default(10) int? pageSize,
    @Default(0) int? pageNo,
    @Default('') String? categoryId,
    @Default('') String? userId,
    @Default('') String? status,
    @Default('') String? searchText,
  }) = _PostRequestParam;
}
