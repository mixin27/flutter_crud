import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:flutter_crud/splash/feat_splash.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: CategoryListPage, path: '/categories'),
  ],
)
class AppRouter extends _$AppRouter {}
