import 'package:flutter_crud/blog/post/feat_post.dart';

extension ExtPostDtoList on List<PostDto> {
  List<PostModel> get domainList => toDomainList();
  List<PostModel> toDomainList() => map((e) => e.domainModel).toList();
}
