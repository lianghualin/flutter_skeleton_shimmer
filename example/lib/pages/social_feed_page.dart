import 'package:flutter/material.dart';

class SocialFeedPage extends StatelessWidget {
  final bool isLoading;
  const SocialFeedPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Social Feed'));
  }
}
