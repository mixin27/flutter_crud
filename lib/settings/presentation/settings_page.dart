import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          ListTile(
            onTap: () {
              context.router.push(const ProfileRoute());
            },
            title: const Text('Profile'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              context.router.push(const ChangePasswordRoute());
            },
            title: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
