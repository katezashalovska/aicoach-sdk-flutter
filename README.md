# AI Coach Jack SDK

A Flutter SDK for integrating AI-driven coaching and chat functionality into mobile applications. It provides a ready-to-use UI for coach selection, session management, and real-time conversation.

## Features

- **Coach Management**: Catalog of AI coaches with specific metadata (expertise, ratings, achievements).
- **Session History**: Persistent tracking of user conversations.
- **Messaging Interface**: Optimized chat UI with standard mobile messaging patterns.
- **Design System**: Fully customizable theme layer to match host application branding.
- **Modular Architecture**: Feature-based internal structure for better maintainability.

## Installation

Add `ai_coach_jack` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  ai_coach_jack: ^1.0.0
```

## Getting Started

The SDK requires a backend configuration and a repository implementation to handle data fetching.

### 1. Initialization

Initialize the configuration and repository. It is recommended to manage these instances using a service locator or provider.

```dart
import 'package:ai_coach_jack/ai_coach_jack.dart';

final config = AiCoachConfig(
  baseUrl: 'https://api.example.com',
  apiKey: 'YOUR_API_KEY',
  userId: 'user_unique_id',
);

final repository = RemoteAiCoachRepository(config: config);
```

### 2. Theming

Customize the visual appearance using `AiCoachTheme`.

```dart
final theme = AiCoachTheme(
  primaryColor: const Color(0xFF7B61FF),
  onAccentColor: Colors.white,
  buttonRadius: 12.0,
);
```

## Usage

### Launching the Full SDK

The `AiCoach.launch` method provides the main entry point, including navigation to chat history and coach selection.

```dart
AiCoach.launch(
  context,
  repository: repository,
  theme: theme,
  userName: 'User Name',
);
```

### Launching a Specific Chat

To bypass the selection screens and start a session directly with a specific coach:

```dart
AiCoach.launchChat(
  context,
  repository: repository,
  theme: theme,
  coachId: 'coach_id',
  userName: 'User Name',
);
```

## API Reference

### AiCoachTheme

| Property | Type | Default |
| :--- | :--- | :--- |
| `primaryColor` | `Color` | `0xFF7B61FF` |
| `onAccentColor` | `Color` | `Colors.white` |
| `backgroundColor` | `Color` | `0xFFFAFAFA` |
| `buttonRadius` | `double` | `12.0` |

## Additional Information

For issues, feature requests, or contributions, please use the project's repository issue tracker.
