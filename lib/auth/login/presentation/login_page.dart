import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

import 'widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      state.maybeMap(
        orElse: () {},
        error: (_) {
          _.failure.map(
            server: (_) {
              showAnimatedDialog(
                context,
                dialog: AppDialogBox(
                  header: Text(
                    AppStrings.authentication,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    _.message ?? AppStrings.unknownError,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            },
            storage: (_) {
              showAnimatedDialog(
                context,
                dialog: AppDialogBox(
                  header: Text(
                    AppStrings.authentication,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    AppStrings.storageError,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            },
          );
        },
      );
    });

    return HideKeyboard(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              const SizedBox(height: 64),
              Text(
                'Welcome to\nBlogs',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                AppStrings.loremIpsum,
                // textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              const LoginForm(),
              const SizedBox(height: 30),
              LoginRegisterSwitch(
                text: "Don't have an account?",
                actionText: 'Register',
                onTap: () {
                  context.router.push(const RegisterRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
