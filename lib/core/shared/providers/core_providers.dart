import 'package:dio/dio.dart';
import 'package:flutter_crud/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

final dioProvider = Provider(
  (ref) => Dio()
    ..options = BaseOptions(
      baseUrl: Env.uatBaseUrl,
      contentType: ApiUtils.formUrlEncoded,
      headers: {
        "apiKey": Env.apiKey,
      },
    ),
);
