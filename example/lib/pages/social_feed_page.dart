import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class SocialFeedPage extends StatelessWidget {
  final bool isLoading;
  const SocialFeedPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _postCard(context,
          name: 'Alice Johnson',
          time: '2 hours ago',
          body: 'Just finished a beautiful hike in the mountains! The views were absolutely breathtaking.',
        ),
        const SizedBox(height: 12),
        _postCard(context,
          name: 'Bob Smith',
          time: '5 hours ago',
          body: 'Working on a new Flutter project today. Shimmer loading states make such a difference!',
        ),
        const SizedBox(height: 12),
        _postCard(context,
          name: 'Carol White',
          time: 'Yesterday',
          body: 'Sunset at the beach was incredible tonight.',
        ),
      ],
    );
  }

  Widget _postCard(
    BuildContext context, {
    required String name,
    required String time,
    required String body,
  }) {
    return Shimmerize(
      enabled: isLoading,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(time,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(body),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(child: Icon(Icons.image, size: 48)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
