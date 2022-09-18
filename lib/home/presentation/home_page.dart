import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              centerTitle: true,
              title: const Text('News Blog'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                controller: tabController,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(90),
                labelColor: Theme.of(context).colorScheme.onSurface,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorWeight: 6,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'All News'),
                  Tab(text: 'Technology'),
                  Tab(text: 'Fashion'),
                  Tab(text: 'Sports'),
                  Tab(text: 'Science'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const [
            Center(child: Text('All News')),
            Center(child: Text('Technology')),
            Center(child: Text('Fashion')),
            Center(child: Text('Sports')),
            Center(child: Text('Science')),
          ],
        ),
      ),
    );
  }
}
