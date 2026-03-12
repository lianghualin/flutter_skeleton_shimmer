# Playground Example App — Design Spec

## Overview

Redesign the `example/` app from a basic 3-section demo into a full **Shimmer Playground** — a multi-page app with a drawer sidebar that showcases every capability of `flutter_skeleton_shimmer` through real-world scenarios and an interactive sandbox.

## Architecture

### Navigation

- **Flutter `Drawer`** sidebar with hamburger menu (☰) in AppBar
- Two sections in the drawer:
  - **Scenarios** — 6 real-world demo pages
  - **Tools** — Sandbox page
- Active page highlighted with left border accent
- Each page has its own AppBar title
- Global shimmer **toggle switch** in every AppBar for quick on/off
- **State management**: Simple widget replacement in `Scaffold.body` (`_pages[_currentIndex]`). State is not preserved across page switches — each page defaults to `_isLoading = true` on mount so users see shimmer immediately.

### Drawer Header

- Title: "Shimmer Playground" in bold
- Subtitle: "flutter_skeleton_shimmer" in muted text
- Background: `Colors.deepPurple` gradient

### File Structure

```
example/lib/
├── main.dart                    # App entry, MaterialApp, Drawer setup
├── pages/
│   ├── social_feed_page.dart    # Social feed scenario
│   ├── user_profile_page.dart   # User profile scenario
│   ├── product_cards_page.dart  # E-commerce grid scenario
│   ├── chat_page.dart           # Chat messages scenario
│   ├── settings_list_page.dart  # Settings/list items scenario
│   ├── article_page.dart        # Article/blog post scenario
│   └── sandbox_page.dart        # Interactive sandbox with controls
└── widgets/
    └── playground_drawer.dart   # Shared drawer widget
```

## Scenario Pages

Each scenario page is wrapped in `Shimmerize(enabled: _isLoading, child: ...)` and demonstrates specific library features.

### 1. Social Feed

- **Purpose**: Demonstrate **auto-detect** on common widgets
- **Layout**: Scrollable list of post cards
- **Each post**: CircleAvatar (avatar), Text (username), Text (timestamp), Text (body paragraph), Image (post image)
- **Shimmer features shown**: Auto-detection of CircleAvatar, Text, Image

### 2. User Profile

- **Purpose**: Demonstrate **mixed auto-detect + Bone markers** and **`Bone.child`** (conditional wrapper pattern)
- **Layout**: Profile header + stats + bio
- **Content**: Large CircleAvatar, Text (name), Text (bio paragraph), Row of 3 stat columns (posts/followers/following using `Bone(child: Text('128'))` so the real number shows when shimmer is off), Bone for a "Follow" button area
- **Shimmer features shown**: Auto-detect for text/avatar, Bone() for custom-shaped placeholders, Bone.child for conditional content

### 3. E-Commerce Product Cards

- **Purpose**: Demonstrate **Bone markers with custom dimensions** in a grid, including **`Bone.borderRadius`** override
- **Layout**: 2-column GridView of product cards (4 products total)
- **Each card**: Bone (product image, full-width, fixed height), Text (product name), Text (price with `Bone(borderRadius: 12)` for pill-shaped price tag), Row of small Bone circles (star rating)
- **Shimmer features shown**: Bone with explicit width/height, Bone.circle, Bone.borderRadius per-bone override, grid layout shimmer

### 4. Chat / Messages

- **Purpose**: Demonstrate shimmer on **varied-width, alternating layout**
- **Layout**: ListView of 6-8 message bubbles, alternating left (received) and right (sent) using `CrossAxisAlignment` and `MainAxisAlignment.end`
- **Each message**: CircleAvatar (sender, left-aligned only), Container with Bone or Text for message content of varying widths (60%-90% of screen width)
- **Shimmer features shown**: Auto-detect on varied content widths, asymmetric layouts

### 5. Settings / List Items

- **Purpose**: Demonstrate auto-detect on **common Flutter ListTile pattern**
- **Layout**: ListView of ListTile widgets grouped by section
- **Content**: Leading Icon, title Text, subtitle Text, trailing Icon or Switch placeholder (Bone)
- **Shimmer features shown**: Auto-detect on Icon, Text within ListTile

### 6. Article / Blog Post

- **Purpose**: Demonstrate **Bone with `double.infinity` width** for full-width blocks
- **Layout**: Single scrollable article
- **Content**: Bone (hero image, full width, 200px height), Text (headline), Row with CircleAvatar + Text (author + date), Multiple Text lines (paragraphs), Bone (inline image)
- **Shimmer features shown**: Bone with double.infinity, auto-detect for text-heavy content

## Sandbox Page

### Layout

Single scrollable `ListView`: preview card at top, controls section below. No pinned/sticky elements — simple vertical scroll.

### Preview Section

A sample card layout (avatar + name + subtitle + content block) wrapped in `ShimmerTheme` + `Shimmerize` that updates in real time as the user adjusts controls.

### Controls Section

All controls modify a `ShimmerThemeData` that wraps the preview via `ShimmerTheme`.

| Control | Widget | Range/Options | Default |
|---------|--------|---------------|---------|
| Enabled | `Switch` | on/off | on |
| Base Color | Row of `GestureDetector` color circles | 4 preset colors: grey `#E0E0E0`, purple `#D4C5F9`, blue `#B8D4E3`, warm `#F9D5C5` | grey |
| Highlight Color | Row of `GestureDetector` color circles | 4 preset colors: light grey `#F5F5F5`, light purple `#ECE4FB`, light blue `#E3F0F7`, light warm `#FDF0EA` | light grey |
| Duration | `Slider` | 500ms — 3000ms | 1500ms |
| Border Radius | `Slider` | 0.0 — 16.0 | 4.0 |

**No external dependencies** — color presets instead of a color picker package, keeping the example aligned with the library's zero-dependency philosophy.

### Duration Limitation

Changing the `duration` slider while shimmer is already running will **not** update the animation speed mid-cycle — the `AnimationController` duration is set once when shimmer starts. The sandbox page works around this by calling `setState` which rebuilds the `Shimmerize` widget with new theme data. If the animation does not visually update, the sandbox should toggle shimmer off/on programmatically when duration changes.

## Shared Components

### PlaygroundDrawer

- Receives current page identifier and `onPageSelected` callback
- Renders drawer header with app name/branding
- Lists all pages grouped under "Scenarios" and "Tools" section headers
- Highlights active page with accent color left border

### Shimmer Toggle

- Present in every page's AppBar as a `Switch` widget with "Loading" label
- Each page manages its own `_isLoading` state
- Toggling switches `Shimmerize.enabled` for all shimmer widgets on that page

## Design Constraints

- **Zero external dependencies** — only Flutter SDK, matching the library's philosophy
- **Material 3** — use `useMaterial3: true` with `Colors.deepPurple` as the color scheme seed
- **Single `example/` directory** — replaces the existing example app entirely
- **Demonstrates every public API**: `Shimmerize`, `Bone`, `Bone.circle`, `Bone.borderRadius`, `Bone.child`, `ShimmerTheme`, `ShimmerThemeData`, `ShimmerThemeData.copyWith`
- **Item counts**: 3-5 items per list/grid scenario to keep demos concise
- **Default state**: All pages start with `_isLoading = true` so users see shimmer on launch
