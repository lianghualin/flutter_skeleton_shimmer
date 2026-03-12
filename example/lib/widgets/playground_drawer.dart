// example/lib/widgets/playground_drawer.dart
import 'package:flutter/material.dart';

enum PlaygroundPage {
  socialFeed,
  userProfile,
  productCards,
  chat,
  settingsList,
  article,
  sandbox,
}

class PlaygroundDrawer extends StatelessWidget {
  final PlaygroundPage currentPage;
  final ValueChanged<PlaygroundPage> onPageSelected;

  const PlaygroundDrawer({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.tertiary,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Shimmer Playground',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'flutter_skeleton_shimmer',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
          _sectionHeader(context, 'Scenarios'),
          _tile(context, PlaygroundPage.socialFeed, Icons.dynamic_feed, 'Social Feed'),
          _tile(context, PlaygroundPage.userProfile, Icons.person, 'User Profile'),
          _tile(context, PlaygroundPage.productCards, Icons.shopping_bag, 'Product Cards'),
          _tile(context, PlaygroundPage.chat, Icons.chat_bubble, 'Chat'),
          _tile(context, PlaygroundPage.settingsList, Icons.settings, 'Settings List'),
          _tile(context, PlaygroundPage.article, Icons.article, 'Article'),
          const Divider(),
          _sectionHeader(context, 'Tools'),
          _tile(context, PlaygroundPage.sandbox, Icons.tune, 'Sandbox'),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              letterSpacing: 1.5,
            ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    PlaygroundPage page,
    IconData icon,
    String label,
  ) {
    final isSelected = currentPage == page;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: isSelected
          ? BoxDecoration(
              border: Border(
                left: BorderSide(color: colorScheme.primary, width: 3),
              ),
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            )
          : null,
      child: ListTile(
        leading: Icon(icon,
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant),
        title: Text(label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? colorScheme.primary : null,
            )),
        onTap: () {
          onPageSelected(page);
          Navigator.pop(context);
        },
      ),
    );
  }
}
