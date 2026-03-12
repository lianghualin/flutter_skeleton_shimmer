// example/lib/pages/article_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class ArticlePage extends StatelessWidget {
  final bool isLoading;
  const ArticlePage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Shimmerize(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bone(
              width: double.infinity,
              height: 200,
              child: Container(
                height: 200,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Center(
                    child: Icon(Icons.image, size: 64, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Building Beautiful Loading States in Flutter',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        child: Icon(Icons.person, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text('Sarah Chen',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(width: 8),
                      Text('Mar 12, 2026',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Skeleton loading screens have become a standard pattern in modern app design. '
                    'Instead of showing a blank screen or a spinner, skeleton screens show a preview '
                    'of the layout that content will fill, giving users a sense of the structure before data arrives.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The shimmer effect adds a subtle animation that sweeps across the skeleton, '
                    'creating a sense of activity and progress. This visual cue helps users understand '
                    'that content is actively loading.',
                  ),
                  const SizedBox(height: 16),
                  Bone(
                    width: double.infinity,
                    height: 150,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Icon(Icons.bar_chart,
                              size: 48, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'With flutter_skeleton_shimmer, adding shimmer loading states is as simple as '
                    'wrapping your widget tree in a Shimmerize widget. The library automatically '
                    'detects Text, Image, Icon, and CircleAvatar widgets and replaces them with '
                    'animated skeleton bones.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'For more control, you can place Bone markers anywhere in your widget tree to '
                    'define custom skeleton shapes. The library supports circles, rounded rectangles, '
                    'and custom border radii — all without any external dependencies.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
