import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final emailValidator = ref.watch(emailValidatorProvider);
        final passwordValidator = ref.watch(passwordValidatorProvider);
        final obscureText = ref.watch(obscureTextProvider);
        final isLoading = ref.watch(isInAuthProgressProvider);

        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  label: Text('Email or phone number'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                validator: passwordValidator,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  label: const Text('Password'),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      ref.read(obscureTextProvider.notifier).state =
                          !obscureText;
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AppStateButton(
                text: 'Login',
                loading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isLoading) return;
                    ref
                        .read(authNotifierProvider.notifier)
                        .signInWithEmailAnPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
