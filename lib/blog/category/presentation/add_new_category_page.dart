import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class AddNewCategoryPage extends StatelessWidget {
  const AddNewCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text(AppStrings.newCategory),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            children: const [
              SizedBox(height: 20),
              NewCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCategoryForm extends ConsumerStatefulWidget {
  const NewCategoryForm({
    Key? key,
  }) : super(key: key);

  @override
  _NewCategoryFormState createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends ConsumerState<NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createLoadingProvider);
    final nameValidator = ref.watch(nameValidatorProvider);

    ref.listen<CreateCategoryState>(
      createCategoryNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          noConnection: (_) {
            showAnimatedDialog(
              context,
              dialog: AppDialogBox(
                header: Text(
                  AppStrings.newCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(
                  AppStrings.connectionProblem,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            );
          },
          success: (_) {
            ref
                .read(getAllCategoriesNotifierProvider.notifier)
                .getAllCategories();

            context.router.pop();
          },
          error: (_) {
            showAnimatedDialog(
              context,
              dialog: AppDialogBox(
                header: Text(
                  AppStrings.newCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(
                  _.failure.message ?? AppStrings.unknownError,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            );
          },
        );
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.categoryName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            validator: nameValidator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text(AppStrings.name),
            ),
          ),
          const SizedBox(height: 20),
          AppStateButton(
            text: 'Save',
            loading: isLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isLoading) return;

                ref
                    .read(createCategoryNotifierProvider.notifier)
                    .createCategory(name: nameController.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
