import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmerize Demo',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmerize Demo'),
        actions: [
          Switch(
            value: _isLoading,
            onChanged: (v) => setState(() => _isLoading = v),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Auto-detect demo
            Text('Auto-detect (Text, Icon)',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Shimmerize(
              enabled: _isLoading,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe',
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text('john.doe@example.com'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Bone marker demo
            Text('Bone markers (explicit)',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Shimmerize(
              enabled: _isLoading,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Bone.circle(size: 48),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bone(width: 150, height: 16),
                              const SizedBox(height: 8),
                              Bone(width: 100, height: 12),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Bone(width: double.infinity, height: 120),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // List demo
            Text('List items',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...List.generate(
              4,
              (i) => Shimmerize(
                enabled: _isLoading,
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.device_hub)),
                  title: Text('Device ${i + 1}'),
                  subtitle: const Text('192.168.1.x'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
