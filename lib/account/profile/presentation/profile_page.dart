import 'package:flutter/material.dart';
import 'package:flutter_crud/account/feat_account.dart';
import 'package:flutter_crud/auth/feat_auth.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smf_core/smf_core.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    // getProfile();
  }

  Future<void> getProfile() async {
    Future.microtask(
        () => ref.read(getProfileNotifierProvider.notifier).getProfile());
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(getProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Profile'),
      ),
      body: profileState.map(
        initial: (_) => const SizedBox(),
        loading: (_) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        noConnection: (_) => ErrorPlaceholderWidget(
          message: AppStrings.connectionProblem,
          icon: Icons.wifi_off,
          onPressed: getProfile,
        ),
        success: (_) {
          final user = _.user;

          return RefreshIndicator(
            onRefresh: getProfile,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                UserInfoCard(user: user),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your articles',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  10,
                  (index) => ListTile(
                    title: Text('Article $index'),
                  ),
                ),
              ],
            ),
          );
        },
        error: (_) => ErrorPlaceholderWidget(
          message: _.failure.message ?? AppStrings.unknownError,
          icon: Icons.person_rounded,
          onPressed: getProfile,
        ),
      ),
    );
  }
}

class UserInfoCard extends ConsumerWidget {
  const UserInfoCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        // color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(getAllCategoriesNotifierProvider.notifier)
                          .resetState();
                      ref.read(authNotifierProvider.notifier).signOut();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    child: const Text(AppStrings.logout),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    user.lastLogin.toFormattedDateTime(),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
