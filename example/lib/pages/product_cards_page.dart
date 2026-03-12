import 'package:flutter/material.dart';

class ProductCardsPage extends StatelessWidget {
  final bool isLoading;
  const ProductCardsPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Product Cards'));
  }
}
