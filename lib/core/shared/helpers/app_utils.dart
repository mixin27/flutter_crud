import 'dart:convert';

Map<String, dynamic> decodeToJson(String data) => jsonDecode(data);

bool boolFromJson(Object? json) => (json as bool?) ?? false;

List<dynamic> listFromJson(Object? json) => (json as List<dynamic>?) ?? [];
