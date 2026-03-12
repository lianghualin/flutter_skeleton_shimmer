// example/lib/pages/chat_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class ChatPage extends StatelessWidget {
  final bool isLoading;
  const ChatPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _message(context, 'Hey! How are you?', isMe: false),
        _message(context, "I'm doing great, thanks! Working on a new Flutter package.", isMe: true),
        _message(context, 'That sounds awesome! What does it do?', isMe: false),
        _message(context, 'It generates shimmer skeleton loading states automatically from your widget tree.', isMe: true),
        _message(context, 'No way, that is really cool!', isMe: false),
        _message(context, "Right? Zero dependencies too. You just wrap your widgets in Shimmerize and it handles the rest.", isMe: true),
        _message(context, 'I need to try that out.', isMe: false),
      ],
    );
  }

  Widget _message(BuildContext context, String text, {required bool isMe}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Shimmerize(
        enabled: isLoading,
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) ...[
              const CircleAvatar(
                radius: 16,
                child: Icon(Icons.person, size: 16),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 16),
                  ),
                ),
                child: Text(text),
              ),
            ),
            if (isMe) const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
