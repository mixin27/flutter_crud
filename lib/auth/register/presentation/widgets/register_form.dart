import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final nameValidator = ref.watch(nameValidatorProvider);
        final emailValidator = ref.watch(emailValidatorProvider);
        final phoneValidator = ref.watch(phoneValidatorProvider);
        final passwordValidator = ref.watch(passwordValidatorProvider);
        final obscureText = ref.watch(obscureTextProvider);
        final isLoading = ref.watch(isInAuthProgressProvider);

        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: nameValidator,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  label: Text('Name'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  label: Text('Email'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: phoneValidator,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_outlined),
                  label: Text('Phone number'),
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
                text: 'Create an account',
                loading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authNotifierProvider.notifier).createUser(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
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
