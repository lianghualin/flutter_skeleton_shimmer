import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class SandboxPage extends StatefulWidget {
  const SandboxPage({super.key});

  @override
  State<SandboxPage> createState() => _SandboxPageState();
}

class _SandboxPageState extends State<SandboxPage> {
  bool _enabled = true;
  int _baseColorIndex = 0;
  int _highlightColorIndex = 0;
  double _durationMs = 1500;
  double _borderRadius = 4.0;

  // Force Shimmerize to re-mount when duration changes,
  // since AnimationController.duration is only set on start.
  int _shimmerKey = 0;

  static const _baseColors = [
    Color(0xFFE0E0E0),
    Color(0xFFD4C5F9),
    Color(0xFFB8D4E3),
    Color(0xFFF9D5C5),
  ];

  static const _highlightColors = [
    Color(0xFFF5F5F5),
    Color(0xFFECE4FB),
    Color(0xFFE3F0F7),
    Color(0xFFFDF0EA),
  ];

  static const _colorLabels = ['Grey', 'Purple', 'Blue', 'Warm'];

  ShimmerThemeData get _themeData => const ShimmerThemeData().copyWith(
        baseColor: _baseColors[_baseColorIndex],
        highlightColor: _highlightColors[_highlightColorIndex],
        duration: Duration(milliseconds: _durationMs.round()),
        borderRadius: _borderRadius,
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview section
        Text('PREVIEW',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  letterSpacing: 1.5,
                )),
        const SizedBox(height: 8),
        ShimmerTheme(
          data: _themeData,
          child: Shimmerize(
            key: ValueKey(_shimmerKey),
            enabled: _enabled,
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
                              Text('Preview User',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall),
                              Text('preview@example.com',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Bone(width: double.infinity, height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Controls section
        Text('THEME CONTROLS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  letterSpacing: 1.5,
                )),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Enabled toggle
                _controlRow(
                  label: 'Enabled',
                  child: Switch(
                    value: _enabled,
                    onChanged: (v) => setState(() => _enabled = v),
                  ),
                ),
                const Divider(),
                // Base color
                _controlRow(
                  label: 'Base Color',
                  child: Row(
                    children: List.generate(_baseColors.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: _colorCircle(
                          color: _baseColors[i],
                          label: _colorLabels[i],
                          isSelected: _baseColorIndex == i,
                          onTap: () =>
                              setState(() => _baseColorIndex = i),
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(),
                // Highlight color
                _controlRow(
                  label: 'Highlight Color',
                  child: Row(
                    children: List.generate(_highlightColors.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: _colorCircle(
                          color: _highlightColors[i],
                          label: _colorLabels[i],
                          isSelected: _highlightColorIndex == i,
                          onTap: () =>
                              setState(() => _highlightColorIndex = i),
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(),
                // Duration slider
                _controlRow(
                  label: 'Duration',
                  trailing: Text('${_durationMs.round()}ms',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: Slider(
                    value: _durationMs,
                    min: 500,
                    max: 3000,
                    divisions: 25,
                    onChanged: (v) => setState(() => _durationMs = v),
                    onChangeEnd: (_) => setState(() => _shimmerKey++),
                  ),
                ),
                const Divider(),
                // Border radius slider
                _controlRow(
                  label: 'Border Radius',
                  trailing: Text(_borderRadius.toStringAsFixed(1),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: Slider(
                    value: _borderRadius,
                    min: 0,
                    max: 16,
                    divisions: 32,
                    onChanged: (v) => setState(() => _borderRadius = v),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _controlRow({
    required String label,
    required Widget child,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              if (trailing != null) trailing,
            ],
          ),
          child,
        ],
      ),
    );
  }

  Widget _colorCircle({
    required Color color,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: label,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
              width: isSelected ? 3 : 1,
            ),
          ),
        ),
      ),
    );
  }
}
