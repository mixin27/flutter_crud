import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class CategoryChooser extends ConsumerWidget {
  const CategoryChooser({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void loadCategories() {
      ref.read(getAllCategoriesNotifierProvider.notifier).getAllCategories();
    }

    final categoriesState = ref.watch(getAllCategoriesNotifierProvider);
    final suggestions = ref.watch(categorySearchSuggestionProvider);

    return Column(
      children: [
        const SizedBox(height: 20),
        // search input
        const CategorySearchField(),

        const SizedBox(height: 20),

        Expanded(
          child: categoriesState.map(
            initial: (_) => const SizedBox(),
            loading: (_) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            empty: (_) => const ErrorPlaceholderWidget(
              icon: Icons.category,
            ),
            noConnection: (_) => ErrorPlaceholderWidget(
              icon: Icons.wifi_off,
              message: AppStrings.connectionProblem,
              onPressed: loadCategories,
            ),
            success: (_) => CategoryList(
              scrollController: scrollController,
              categories: suggestions.isEmpty ? _.categories : suggestions,
              onItemTap: (category) {
                Logger.d('CategoryChooser', category.name);
                ref.read(selectedCategoryProvider.notifier).state = category;
                context.router.pop();
              },
            ),
            error: (_) => ErrorPlaceholderWidget(
              icon: Icons.category,
              message: _.failure.message ?? AppStrings.unknownError,
              onPressed: loadCategories,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categories,
    this.scrollController,
    this.onItemTap,
  }) : super(key: key);

  final List<CategoryModel> categories;
  final ScrollController? scrollController;
  final Function(CategoryModel category)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories.elementAt(index);
        return ListTile(
          onTap: () {
            if (onItemTap == null) return;
            onItemTap!(category);
          },
          title: Text(category.name),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

final categorySearchSuggestionProvider = StateProvider<List<CategoryModel>>(
  (ref) => [],
);

class CategorySearchField extends ConsumerStatefulWidget {
  const CategorySearchField({super.key});

  @override
  _CategorySearchFieldState createState() => _CategorySearchFieldState();
}

class _CategorySearchFieldState extends ConsumerState<CategorySearchField> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void searchItem(String? searchTerm, List<CategoryModel> items) {
    if (searchTerm == null || searchTerm.isEmpty) {
      return;
    }

    final suggestions = items.where((element) {
      final title = element.name.toLowerCase();
      final input = searchTerm.trim().toLowerCase();
      return title.contains(input);
    }).toList();
    ref.read(categorySearchSuggestionProvider.notifier).state = suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(sortedCategoryListProvider);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search categories',
        ),
        onChanged: (value) {
          searchItem(value, categories);
        },
      ),
    );
  }
}
