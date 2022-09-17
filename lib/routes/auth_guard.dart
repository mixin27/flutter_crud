import 'package:auto_route/auto_route.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/routes/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final UserAuthenticator authenticator;

  AuthGuard(this.authenticator);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await authenticator.isSignedIn()) {
      resolver.next(true);
    } else {
      router.push(const EmptyAuthRoute(
        children: [LoginRoute()],
      ));
    }
  }
}
