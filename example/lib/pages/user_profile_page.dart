import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final bool isLoading;
  const UserProfilePage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('User Profile'));
  }
}
