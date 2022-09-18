import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text('Create New Article'),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 35,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Add Article Cover',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const NewArticleForm(),
          ],
        ),
      ),
    );
  }
}

class NewArticleForm extends ConsumerStatefulWidget {
  const NewArticleForm({
    Key? key,
  }) : super(key: key);

  @override
  _NewArticleFormState createState() => _NewArticleFormState();
}

class _NewArticleFormState extends ConsumerState<NewArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {}

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void showCategoryChooserDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DismissibleWidget(
          child: DraggableScrollableSheet(
            minChildSize: 0.5,
            maxChildSize: 0.8,
            initialChildSize: 0.6,
            builder: (context, scrollController) => AppModalBottomSheet(
              child: CategoryChooser(
                scrollController: scrollController,
              ),
            ),
          ),
        );
      },
    );
  }

  void showMessage(String message) {
    showAnimatedDialog(
      context,
      dialog: AppDialogBox(
        header: Text(
          'Create New Article',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isLoading = ref.watch(createPostLoading);
    final titleValidator = ref.watch(titleValidatorProvider);
    final contentValidator = ref.watch(contentValidatorProvider);

    ref.listen<CreatePostState>(
      createPostNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          success: (_) {
            ref.read(selectedCategoryProvider.notifier).state = null;
            ref.read(getAllPostsNotifierProvider.notifier).getFirstPage();
            context.router.pop();
          },
          noConnection: (_) {
            showMessage(AppStrings.connectionProblem);
          },
          error: (_) {
            showMessage(_.failure.message ?? AppStrings.unknownError);
          },
        );
      },
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: titleController,
            validator: titleValidator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text('Title'),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Content',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: contentController,
            validator: contentValidator,
            maxLines: 8,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: 'Write something here',
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: showCategoryChooserDialog,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: selectedCategory?.name ?? 'Select category',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                suffixIcon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppStateButton(
            text: 'Publish',
            loading: isLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isLoading) return;

                if (selectedCategory == null) {
                  showMessage('Please select category');
                  return;
                }

                ref.read(createPostNotifierProvider.notifier).createPost(
                      title: titleController.text,
                      content: contentController.text,
                      status: 'Published',
                      categoryId: selectedCategory.id,
                    );
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
