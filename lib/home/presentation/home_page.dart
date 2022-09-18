import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:flutter_crud/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    //
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
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(getAllCategoriesNotifierProvider);
    final sortedCategories = ref.watch(categoryListProvider);

    ref.listen<GetAllCategoriesState>(
      getAllCategoriesNotifierProvider,
      (previous, next) {
        next.maybeMap(
          orElse: () {},
          success: (_) {
            tabController = TabController(
              length: _.categories.length,
              vsync: this,
            );
          },
        );
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(scaffoldKey: _scaffoldKey),
      body: RefreshIndicator(
        onRefresh: getAllCategories,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                centerTitle: true,
                title: const Text('News Blog'),
                pinned: true,
                floating: true,
                bottom: categoriesState.maybeMap(
                  orElse: () => null,
                  success: (_) => TabBar(
                    controller: tabController,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onSurface.withAlpha(90),
                    labelColor: Theme.of(context).colorScheme.onSurface,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    indicatorWeight: 6,
                    isScrollable: true,
                    tabs: List.generate(
                      sortedCategories.length,
                      (index) {
                        final category = sortedCategories.elementAt(index);
                        return Tab(text: category.name);
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: categoriesState.map(
            initial: (_) => const SizedBox(),
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            empty: (_) => const SizedBox(),
            noConnection: (_) => ErrorPlaceholderWidget(
              message: AppStrings.connectionProblem,
              icon: Icons.wifi_off,
              onPressed: getAllCategories,
            ),
            success: (_) => TabBarView(
              controller: tabController,
              children: List.generate(
                sortedCategories.length,
                (index) {
                  final category = sortedCategories.elementAt(index);
                  return Text(category.name);
                },
              ),
            ),
            error: (_) => ErrorPlaceholderWidget(
              message: _.failure.message ?? AppStrings.unknownError,
              onPressed: getAllCategories,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 130,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              child: ListTile(
                onTap: () {
                  _scaffoldKey.currentState!.closeDrawer();
                  context.router.push(const ProfileRoute());
                },
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('Kyaw Zayar Tun'),
                subtitle: const Text('kyawzayartun.sbs@gmail.com'),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              _scaffoldKey.currentState!.closeDrawer();
              context.router.replaceAll([const EmptyHomeRoute()]);
            },
            title: const Text('Home'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              _scaffoldKey.currentState!.closeDrawer();
              context.router.push(const CategoryListRoute());
            },
            title: const Text('Categories'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              _scaffoldKey.currentState!.closeDrawer();
            },
            title: const Text('Bookmark'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              _scaffoldKey.currentState!.closeDrawer();
            },
            title: const Text('Setting'),
          ),
          const Divider(),
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationIcon: Icon(Icons.newspaper),
            applicationName: 'News Blog',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2022 Kyaw Zayar Tun',
            aboutBoxChildren: [],
            child: Text('About'),
          ),
        ],
      ),
    );
  }
}
