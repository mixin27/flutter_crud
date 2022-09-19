import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text(AppStrings.editCategory),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              EditCategoryForm(category: category),
            ],
          ),
        ),
      ),
    );
  }
}

class EditCategoryForm extends ConsumerStatefulWidget {
  const EditCategoryForm({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  _EditCategoryFormState createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends ConsumerState<EditCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    nameController.text = widget.category.name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameValidator = ref.watch(nameValidatorProvider);

    ref.listen<UpdateCategoryState>(
      updateCategoryNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          noConnection: (_) {
            setState(() => _isLoading = false);
            showAnimatedDialog(
              context,
              dialog: AppDialogBox(
                header: Text(
                  AppStrings.editCategory,
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
            setState(() => _isLoading = false);
            showAnimatedDialog(
              context,
              dialog: AppDialogBox(
                header: Text(
                  AppStrings.editCategory,
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
            text: AppStrings.update,
            loading: _isLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_isLoading) return;

                setState(() => _isLoading = true);

                ref
                    .read(updateCategoryNotifierProvider.notifier)
                    .updateCategory(
                      id: widget.category.id,
                      name: nameController.text.trim(),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
