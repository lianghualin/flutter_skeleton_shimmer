import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final bool isLoading;
  const ChatPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Chat'));
  }
}
