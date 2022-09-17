import 'package:flutter_crud/blog/post/feat_post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request_param_dto.freezed.dart';
part 'post_request_param_dto.g.dart';

@freezed
class PostRequestParamDto with _$PostRequestParamDto {
  const PostRequestParamDto._();
  const factory PostRequestParamDto({
    @JsonKey(name: 'pageSize') @Default(10) int pageSize,
    @JsonKey(name: 'pageNo') @Default(0) int pageNo,
    @JsonKey(name: 'postCategoryID') @Default('') String categoryId,
    @JsonKey(name: 'userID') @Default('') String userId,
    @JsonKey(name: 'postStatus') @Default('') String status,
    @JsonKey(name: 'searchText') @Default('') String searchText,
  }) = _PostRequestParamDto;

  factory PostRequestParamDto.fromJson(Map<String, dynamic> json) =>
      _$PostRequestParamDtoFromJson(json);

  factory PostRequestParamDto.fromDomain(PostRequestParam _) =>
      PostRequestParamDto(
        pageSize: _.pageSize ?? 10,
        pageNo: _.pageNo ?? 0,
        categoryId: _.categoryId ?? '',
        userId: _.userId ?? '',
        status: _.status ?? '',
        searchText: _.searchText ?? '',
      );
}
