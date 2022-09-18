import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryListPage extends ConsumerStatefulWidget {
  const CategoryListPage({super.key});

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends ConsumerState<CategoryListPage> {
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

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('Categories'),
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
            itemBuilder: (context, index) {
              final category = _.categories.elementAt(index);
              return ListTile(
                onTap: () {},
                title: Text(category.name),
                leading: ActiveDotIndicator(active: category.active),
                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.delete,
                //     color: Theme.of(context).colorScheme.error,
                //   ),
                // ),
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
