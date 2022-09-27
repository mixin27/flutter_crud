import 'package:flutter/material.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class CategoryListPage extends HookConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(getAllCategoriesNotifierProvider);

    Future<void> getCategories() async {
      Future.microtask(
        () => ref.read(getAllCategoriesNotifierProvider.notifier).all(),
      );
    }

    useEffect(() {
      getCategories();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: categoryState.map(
          initial: (_) => const SizedBox(),
          loading: (_) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          empty: (_) => const SmfErrorPlaceholder(
            message: 'No categories found.',
            icon: Icons.newspaper,
          ),
          noConnection: (_) => SmfErrorPlaceholder(
            message: AppStrings.connectionProblem,
            icon: Icons.wifi_off,
            onPressed: getCategories,
          ),
          success: (_) => RefreshIndicator(
            onRefresh: getCategories,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                final category = _.categories.elementAt(index);
                return ListTile(
                  onTap: () {},
                  title: Text(category.name),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _.categories.length,
            ),
          ),
          error: (_) => SmfErrorPlaceholder(
            message: _.failure.message ?? AppStrings.unknownError,
            icon: Icons.newspaper,
            onPressed: getCategories,
          ),
        ),
      ),
    );
  }
}
