import 'package:flutter/material.dart';
import 'widgets/playground_drawer.dart';
import 'pages/social_feed_page.dart';
import 'pages/user_profile_page.dart';
import 'pages/product_cards_page.dart';
import 'pages/chat_page.dart';
import 'pages/settings_list_page.dart';
import 'pages/article_page.dart';
import 'pages/sandbox_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const PlaygroundShell(),
    );
  }
}

class PlaygroundShell extends StatefulWidget {
  const PlaygroundShell({super.key});

  @override
  State<PlaygroundShell> createState() => _PlaygroundShellState();
}

class _PlaygroundShellState extends State<PlaygroundShell> {
  PlaygroundPage _currentPage = PlaygroundPage.socialFeed;
  bool _isLoading = true;

  String get _title {
    switch (_currentPage) {
      case PlaygroundPage.socialFeed:
        return 'Social Feed';
      case PlaygroundPage.userProfile:
        return 'User Profile';
      case PlaygroundPage.productCards:
        return 'Product Cards';
      case PlaygroundPage.chat:
        return 'Chat';
      case PlaygroundPage.settingsList:
        return 'Settings List';
      case PlaygroundPage.article:
        return 'Article';
      case PlaygroundPage.sandbox:
        return 'Sandbox';
    }
  }

  Widget _buildPage() {
    switch (_currentPage) {
      case PlaygroundPage.socialFeed:
        return SocialFeedPage(isLoading: _isLoading);
      case PlaygroundPage.userProfile:
        return UserProfilePage(isLoading: _isLoading);
      case PlaygroundPage.productCards:
        return ProductCardsPage(isLoading: _isLoading);
      case PlaygroundPage.chat:
        return ChatPage(isLoading: _isLoading);
      case PlaygroundPage.settingsList:
        return SettingsListPage(isLoading: _isLoading);
      case PlaygroundPage.article:
        return ArticlePage(isLoading: _isLoading);
      case PlaygroundPage.sandbox:
        return const SandboxPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSandbox = _currentPage == PlaygroundPage.sandbox;
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          if (!isSandbox) ...[
            const Text('Loading'),
            Switch(
              value: _isLoading,
              onChanged: (v) => setState(() => _isLoading = v),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
      drawer: PlaygroundDrawer(
        currentPage: _currentPage,
        onPageSelected: (page) => setState(() {
          _currentPage = page;
          _isLoading = true;
        }),
      ),
      body: _buildPage(),
    );
  }
}
