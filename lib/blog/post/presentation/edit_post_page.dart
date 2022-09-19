import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class EditPostPage extends ConsumerStatefulWidget {
  const EditPostPage({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends ConsumerState<EditPostPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    // getArticle();
  }

  Future<void> getArticle() async {
    ref
        .read(getSinglePostNotifierProvider.notifier)
        .getPostById(id: widget.post.id);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(selectedCategoryProvider.notifier).state = null;
        return true;
      },
      child: HideKeyboard(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
            title: const Text(AppStrings.editArticle),
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
              EditArticleForm(post: widget.post),
            ],
          ),
        ),
      ),
    );
  }
}

class EditArticleForm extends ConsumerStatefulWidget {
  const EditArticleForm({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  _EditArticleFormState createState() => _EditArticleFormState();
}

class _EditArticleFormState extends ConsumerState<EditArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    titleController.text = widget.post.title;
    contentController.text = widget.post.content;

    Future.microtask(() {
      final categories = ref.watch(categoryListProvider);
      final category = BlogHelpers.getCategory(
        widget.post.categoryId,
        categories,
      );

      ref.read(selectedCategoryProvider.notifier).state = category;
    });
  }

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
          AppStrings.editArticle,
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
    final titleValidator = ref.watch(titleValidatorProvider);
    final contentValidator = ref.watch(contentValidatorProvider);

    ref.listen<UpdatePostState>(
      updatePostNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          success: (_) {
            ref.read(getAllPostsNotifierProvider.notifier).getFirstPage();
            ref
                .read(getSinglePostNotifierProvider.notifier)
                .getPostById(id: widget.post.id);
            context.router.pop();
          },
          noConnection: (_) {
            setState(() => _isLoading = false);
            showMessage(AppStrings.connectionProblem);
          },
          error: (_) {
            setState(() => _isLoading = false);
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
            loading: _isLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_isLoading) return;

                setState(() => _isLoading = true);

                if (selectedCategory == null) {
                  showMessage('Please select category');
                  return;
                }

                ref.read(updatePostNotifierProvider.notifier).updatePost(
                      id: widget.post.id,
                      title: titleController.text,
                      content: contentController.text,
                      status: widget.post.status,
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
