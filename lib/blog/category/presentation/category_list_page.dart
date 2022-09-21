import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class CategoryListPage extends ConsumerStatefulWidget {
  const CategoryListPage({super.key});

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends ConsumerState<CategoryListPage> {
  static const String tag = 'CategoryListPage';

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    // getAllCategories();
  }

  Future<void> getAllCategories() async {
    Future.microtask(() =>
        ref.read(getAllCategoriesNotifierProvider.notifier).getAllCategories());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(getAllCategoriesNotifierProvider);

    ref.listen<DeleteCategoryState>(
      deleteCategoryNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          loading: (_) {},
          noConnection: (_) {
            showDialog(
              context: context,
              builder: (context) => AppDialogBox(
                header: Text(
                  AppStrings.deleteCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(
                  AppStrings.connectionProblem,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          },
          success: (_) {
            ref
                .read(getAllCategoriesNotifierProvider.notifier)
                .getAllCategories();
            Logger.clap(tag, 'Deleting category success.');
          },
          error: (_) {
            Logger.e(tag, _.failure.message ?? AppStrings.unknownError);
            showDialog(
              context: context,
              builder: (context) => AppDialogBox(
                header: Text(
                  AppStrings.deleteCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(
                  _.failure.message ?? AppStrings.unknownError,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppStrings.categories),
      ),
      floatingActionButton: const AddCategoryButton(),
      body: categoriesState.map(
        initial: (_) => const SizedBox(),
        loading: (_) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        empty: (_) => const ErrorPlaceholderWidget(
          message: 'No categories found',
          icon: Icons.category,
        ),
        noConnection: (_) => ErrorPlaceholderWidget(
          message: AppStrings.connectionProblem,
          icon: Icons.wifi_off,
          onPressed: getAllCategories,
        ),
        success: (_) => RefreshIndicator(
          onRefresh: getAllCategories,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              final category = _.categories.elementAt(index);
              return ListTile(
                onTap: () {
                  context.router.push(EditCategoryRoute(category: category));
                },
                title: Text(category.name),
                leading: ActiveDotIndicator(active: category.active),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AppDialogBox(
                        header: Text(
                          AppStrings.deleteCategory,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        content: Text(
                          'Are you sure you want to delete ${category.name}?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        footer: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                ref
                                    .read(
                                        deleteCategoryNotifierProvider.notifier)
                                    .deleteCategoryById(id: 'category.id');
                              },
                              child: const Text(AppStrings.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _.categories.length,
          ),
        ),
        error: (_) => ErrorPlaceholderWidget(
          message: _.failure.message ?? AppStrings.unknownError,
          icon: Icons.category,
          onPressed: getAllCategories,
        ),
      ),
    );
  }
}
