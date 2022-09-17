import 'package:flutter_crud/blog/post/feat_post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smf_core/smf_core.dart';

part 'paginated_post_dto.freezed.dart';
part 'paginated_post_dto.g.dart';

@freezed
class PaginatedPostDto with _$PaginatedPostDto {
  const PaginatedPostDto._();
  const factory PaginatedPostDto({
    @JsonKey(name: 'totalRecord', fromJson: stringFromJson)
        required String totalRecord,
    @JsonKey(name: 'totalPage', fromJson: stringFromJson)
        required String totalPage,
    @JsonKey(name: 'currentPageNo', fromJson: stringFromJson)
        required String currentPageNo,
    @JsonKey(name: 'postList', defaultValue: []) required List<PostDto> posts,
  }) = _PaginatedPostDto;

  factory PaginatedPostDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPostDtoFromJson(json);

  int get page => currentPageNo.valInt ?? 0;
  int get total => totalPage.valInt ?? 0;
  int get itemCount => totalRecord.valInt ?? 0;
}
