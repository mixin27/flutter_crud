import 'package:flutter/material.dart';
import 'package:flutter_crud/app_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialization prefs
  await initialize();

  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}
