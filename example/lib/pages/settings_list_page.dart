import 'package:flutter/material.dart';

class SettingsListPage extends StatelessWidget {
  final bool isLoading;
  const SettingsListPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings List'));
  }
}
