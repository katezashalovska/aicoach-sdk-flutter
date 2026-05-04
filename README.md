# ai_coach_jack

A Flutter SDK for integrating an AI-powered coaching experience into your mobile application. The package ships a complete, ready-to-use UI layer covering coach discovery, session management, and real-time streamed chat — all fully themeable to match your brand.

## Features

- Real-time AI responses delivered via Server-Sent Events (SSE) with progressive text rendering
- Coach catalog with ratings, tags, and detailed profile views
- Persistent session history across app launches
- Multiple navigation entry points to fit any app architecture
- Comprehensive theming system — override every color, radius, and text style

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  ai_coach_jack: ^1.0.0
```

Then run:

```sh
flutter pub get
```

## Getting Started

### 1. Initialize the SDK

Call `AiCoach.init` once before the widget tree is built, typically in `main()` or immediately after the user authenticates in your app.

```dart
import 'package:flutter/material.dart';
import 'package:ai_coach_jack/ai_coach_jack.dart';

void main() {
  AiCoach.init(
    apiKey: 'YOUR_API_KEY',
    userId: 'current_user_id',
    userName: 'Jane',
  );

  runApp(const MyApp());
}
```

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `apiKey` | `String` | Yes | API key provided with your SDK license. |
| `userId` | `String` | Yes | Unique identifier for the current user. |
| `userName` | `String` | No | Display name shown in the chat greeting. Defaults to `'User'`. |
| `baseUrl` | `String` | No | Override the default backend URL. |
| `theme` | `AiCoachTheme` | No | Visual configuration. See [Theming](#theming). |
| `customRepository` | `AiCoachRepository` | No | Provide a custom repository implementation for testing. |

### 2. Launch the SDK

Once initialized, open any part of the SDK from any `BuildContext`:

```dart
// Full experience — home screen with navigation to chats and coaches
AiCoach.launch(context);

// Open the user's chat session list directly
AiCoach.launchChats(context);

// Open the coach selection catalog
AiCoach.launchCoachList(context);

// Start or resume a conversation with a specific coach
AiCoach.launchChat(context, coachId: 'coach_id');
```

Each of these methods pushes a new route onto the existing `Navigator`, so the user's back button will return them to whichever screen in your app made the call.

## Navigation

The SDK exposes four static methods on `AiCoach` for navigation:

| Method | Entry point | Back navigates to |
| :--- | :--- | :--- |
| `AiCoach.launch(context)` | SDK home screen | Your calling screen |
| `AiCoach.launchChats(context)` | Chat session list | Your calling screen |
| `AiCoach.launchCoachList(context)` | Coach catalog | Your calling screen |
| `AiCoach.launchChat(context, coachId: ...)` | A specific chat | Your calling screen |

Because the SDK uses standard `Navigator.push`, there is no special setup required — the navigation stack of your host application is preserved at all times.

## Theming

Pass an `AiCoachTheme` instance to `AiCoach.init` to apply your brand colors and typography across every screen in the SDK.

```dart
AiCoach.init(
  apiKey: 'YOUR_API_KEY',
  userId: 'current_user_id',
  theme: AiCoachTheme(
    primaryColor: Color(0xFF00C853),
    backgroundColor: Color(0xFFF5F5F5),
    onAccentColor: Colors.white,
    buttonRadius: 16.0,
  ),
);
```

### AiCoachTheme reference

#### Colors

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `primaryColor` | `Color` | `0xFF7B61FF` | Buttons, icons, borders, and active indicators. |
| `backgroundColor` | `Color` | `0xFFFAFAFA` | Screen background. |
| `cardBackgroundColor` | `Color` | `0xFFF7F7F7` | Background of coach cards and list items. |
| `cardBorderColor` | `Color` | `0xFFD4D4D4` | Border color of cards and input fields. |
| `secondaryTextColor` | `Color` | `0xFFAFAFAF` | Subtitles, timestamps, and placeholder text. |
| `onAccentColor` | `Color` | `Colors.white` | Text and icons placed on top of `primaryColor`. |
| `tagBackgroundColor` | `Color` | `0x66000000` | Background of skill/tag chips on coach cards. |
| `placeholderColor` | `Color` | `0xFFEEEEEE` | Avatar and image placeholder backgrounds. |

#### Shape

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `buttonRadius` | `double` | `12.0` | Border radius applied to buttons, cards, and input fields. |

#### Typography

Text styles for each role (titles, headings, body, buttons) can be overridden via `AiCoachTheme` the same way as colors. The SDK uses **Inter** throughout by default.

## Updating the User

If the user changes after initialization (for example, after a sign-out and sign-in), update the SDK with the new user's credentials:

```dart
AiCoach.updateUserId('new_user_id');
```

## Additional Information

For feature requests, integration questions, or API documentation, please contact the SDK maintainers through your licensed distribution channel.
