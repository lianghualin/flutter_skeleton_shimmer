# flutter_skeleton_shimmer

A hybrid shimmer skeleton loading widget for Flutter. Auto-detects `Text`, `Icon`, and `Image` widgets and supports explicit `Bone()` markers.

## Features

- Automatically replaces `Text`, `Icon`, and `Image` widgets with shimmering skeleton bones
- Explicit `Bone()` widget for custom skeleton placeholders
- Themeable via `ShimmerTheme` and `ShimmerThemeData`
- Smooth animated shimmer effect

## Usage

```dart
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

// Wrap any widget tree with Shimmerize to apply the skeleton effect
Shimmerize(
  loading: true,
  child: Column(
    children: [
      Text('This will become a skeleton bone'),
      Icon(Icons.star),
      Image.network('https://example.com/image.png'),
      // Explicit bone with custom size
      Bone(width: 200, height: 16),
    ],
  ),
)
```

## API Reference

### `Shimmerize`

The main widget that wraps your content and applies the shimmer skeleton effect.

| Property | Type | Description |
|----------|------|-------------|
| `loading` | `bool` | Whether to show the skeleton shimmer |
| `child` | `Widget` | The widget tree to shimmerize |
| `theme` | `ShimmerThemeData?` | Optional theme override |

### `Bone`

An explicit skeleton placeholder widget.

| Property | Type | Description |
|----------|------|-------------|
| `width` | `double?` | Width of the bone |
| `height` | `double?` | Height of the bone |
| `borderRadius` | `BorderRadius?` | Corner radius of the bone |

### `ShimmerThemeData`

Configuration for the shimmer appearance.

| Property | Type | Description |
|----------|------|-------------|
| `baseColor` | `Color` | The base color of the shimmer |
| `highlightColor` | `Color` | The highlight color of the shimmer |
| `duration` | `Duration` | Animation duration |

### `ShimmerTheme`

An inherited widget that provides `ShimmerThemeData` to the widget tree.

## License

MIT
