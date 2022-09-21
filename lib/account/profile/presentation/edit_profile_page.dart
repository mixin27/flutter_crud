import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    Future.microtask(() {
      final user = ref.watch(userProfileProvider);
      if (user != null) {
        nameController.text = user.name;
        emailController.text = user.email;
        phoneController.text = user.phone;
        descriptionController.text = user.description;
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    showAnimatedDialog(
      context,
      dialog: AppDialogBox(
        header: Text(
          AppStrings.updateProfile,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(message, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UpdateProfileState>(
      updateProfileNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          noConnection: (_) {
            setState(() => _isLoading = false);
            showMessage(AppStrings.connectionProblem);
          },
          success: (_) {
            setState(() => _isLoading = false);
            ref.read(getProfileNotifierProvider.notifier).getProfile();
            context.router.pop();
          },
          error: (_) {
            setState(() => _isLoading = false);
            showMessage(_.failure.message ?? AppStrings.unknownError);
          },
        );
      },
    );

    final user = ref.watch(userProfileProvider);
    if (user == null) return const SizedBox();

    final nameValidator = ref.watch(nameValidatorProvider);
    final emailValidator = ref.watch(emailValidatorProvider);
    final phoneValidator = ref.watch(phoneValidatorProvider);

    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text('Edit Profile'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    AppStrings.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: nameValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(AppStrings.name),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // email
                  Text(
                    AppStrings.email,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(AppStrings.email),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // phone
                  Text(
                    AppStrings.phone,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: phoneValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(AppStrings.phone),
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // description
                  Text(
                    AppStrings.bio,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write something',
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
                            .read(updateProfileNotifierProvider.notifier)
                            .updateProfile(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: phoneController.text.trim(),
                              description: descriptionController.text,
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
