import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final bool isLoading;
  const ArticlePage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Article'));
  }
}
