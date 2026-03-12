import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class UserProfilePage extends StatelessWidget {
  final bool isLoading;
  const UserProfilePage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Shimmerize(
      enabled: isLoading,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 48,
              child: Icon(Icons.person, size: 48),
            ),
            const SizedBox(height: 16),
            Text('Jane Doe',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Flutter developer & open source enthusiast',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statColumn(context, 'Posts', '128'),
                _statColumn(context, 'Followers', '2.4k'),
                _statColumn(context, 'Following', '387'),
              ],
            ),
            const SizedBox(height: 24),
            Bone(
              width: 200,
              height: 44,
              borderRadius: 22,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Follow'),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const Text(
                      'Passionate about building beautiful mobile apps with Flutter. '
                      'Contributing to the open source community since 2020. '
                      'Based in San Francisco.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Bone(
          width: 50,
          height: 24,
          child: Text(value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
