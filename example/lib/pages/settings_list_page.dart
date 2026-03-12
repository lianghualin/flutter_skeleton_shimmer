// example/lib/pages/settings_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class SettingsListPage extends StatelessWidget {
  final bool isLoading;
  const SettingsListPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Shimmerize(
      enabled: isLoading,
      child: ListView(
        children: [
          _sectionHeader(context, 'Account'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            subtitle: const Text('Update your personal info'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Privacy'),
            subtitle: const Text('Manage your data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            subtitle: const Text('Push and email alerts'),
            trailing: Bone(
              width: 48,
              height: 28,
              borderRadius: 14,
              child: Switch(value: true, onChanged: (_) {}),
            ),
          ),
          const Divider(),
          _sectionHeader(context, 'Preferences'),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle dark theme'),
            trailing: Bone(
              width: 48,
              height: 28,
              borderRadius: 14,
              child: Switch(value: false, onChanged: (_) {}),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _sectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('0.1.0'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              letterSpacing: 1.5,
            ),
      ),
    );
  }
}
