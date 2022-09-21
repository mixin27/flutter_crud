import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    showAnimatedDialog(
      context,
      dialog: AppDialogBox(
        header: Text(
          AppStrings.changePassword,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(message, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final passwordValidator = ref.watch(passwordValidatorProvider);
    final obscureText = ref.watch(obscureTextProvider);

    ref.listen<ChangePasswordState>(
      changePasswordNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          noConnection: (_) {
            setState(() => _isLoading = false);
            showMessage(AppStrings.connectionProblem);
          },
          success: (_) {
            setState(() => _isLoading = false);
            context.router.replace(const ProfileRoute());
          },
          error: (_) {
            setState(() => _isLoading = false);
            showMessage(_.failure.message ?? AppStrings.unknownError);
          },
        );
      },
    );

    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text('Change Password'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const SizedBox(height: 20),
            Text(
              AppStrings.loremIpsum,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: oldPassController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      label: Text('Old Password'),
                      // suffixIcon: GestureDetector(
                      //   onTap: () {
                      //     ref.read(obscureTextProvider.notifier).state =
                      //         !obscureText;
                      //   },
                      //   child: Icon(
                      //     obscureText ? Icons.visibility_off : Icons.visibility,
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: newPassController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      label: const Text('New Password'),
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
                    text: AppStrings.save,
                    loading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isLoading) return;

                        setState(() => _isLoading = true);

                        ref
                            .read(changePasswordNotifierProvider.notifier)
                            .changePassword(
                              oldPassword: oldPassController.text,
                              newPassword: newPassController.text,
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
