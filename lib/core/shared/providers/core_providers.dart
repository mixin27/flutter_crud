import 'package:dio/dio.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider(
  (ref) => Dio(),
);

final sembastProvider = Provider(
  (ref) => SembastDatabase(),
);
