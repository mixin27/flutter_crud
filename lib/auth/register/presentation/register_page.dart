import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

import 'widgets/register_form.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const SizedBox(height: 20),
              Row(
                children: const [
                  AutoLeadingButton(),
                ],
              ),
              const SizedBox(height: 20),
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
              const RegisterForm(),
              const SizedBox(height: 30),
              LoginRegisterSwitch(
                text: 'Already have and account?',
                actionText: 'Login',
                onTap: () {
                  context.router.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
