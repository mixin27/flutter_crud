import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/home/feat_home.dart';
import 'package:flutter_crud/splash/feat_splash.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(
      page: EmptyAuthPage,
      path: '/auth',
      children: [
        AutoRoute(page: LoginPage, initial: true),
        AutoRoute(page: RegisterPage, path: 'register'),
      ],
    ),
    AutoRoute(
      page: EmptyHomePage,
      path: '/home',
      children: [
        AutoRoute(page: HomePage, initial: true),
        AutoRoute(page: CategoryListPage, path: 'categories'),
        AutoRoute(page: ProfilePage, path: 'me'),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {
  // AppRouter({required super.authGuard});
}
