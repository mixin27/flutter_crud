import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/env.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

final initializationProvider = FutureProvider<Unit>(
  (ref) async {
    // initialization stuffs
    ref.read(dioProvider)
      ..options = BaseOptions(
        baseUrl: Env.uatBaseUrl,
        headers: {
          ApiUtils.keyAccept: ApiUtils.applicationJson,
          "apiKey": Env.apiKey,
        },
        validateStatus: (status) =>
            status != null && status >= 200 && status < 400,
      )
      ..interceptors.add(ref.read(authInterceptorProvider));

    // auth
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.checkAndUpdateAuthStatus();

    return unit;
  },
);

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        authenticated: () {
          ref
              .read(getAllCategoriesNotifierProvider.notifier)
              .getAllCategories();
          _appRouter.replaceAll([const EmptyHomeRoute()]);
        },
        unauthenticated: () {
          _appRouter.replaceAll([const EmptyAuthRoute()]);
        },
      );
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Demo',
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ref.watch(themeModeProvider),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
    );
  }
}
