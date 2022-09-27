import 'package:flutter/material.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:flutter_crud/category/feat_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: const Text('News Blog'),
          bottom: TabBar(
            unselectedLabelColor:
                Theme.of(context).colorScheme.onSurface.withAlpha(90),
            labelColor: Theme.of(context).colorScheme.onSurface,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 6,
            tabs: [
              Column(
                children: const [
                  Icon(Icons.newspaper),
                  SizedBox(height: 5),
                  Text('Articles'),
                  SizedBox(height: 5),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.category),
                  SizedBox(height: 5),
                  Text('Categories'),
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ArticleListPage(),
            CategoryListPage(),
          ],
        ),
      ),
    );
  }
}
