import 'package:flutter/material.dart';
import '../models/ai_coach_config.dart';
import '../repository/ai_coach_repository.dart';
import '../repository/remote_ai_coach_repository.dart';
import '../theme/ai_coach_theme.dart';
import '../ui/home/screens/ai_coach_home_view.dart';
import '../ui/coach_list/screens/ai_coach_list_view.dart';
import '../ui/chats_list/screens/ai_coach_chats_view.dart';
import '../models/coach.dart';
import '../ui/coach_details/screens/ai_coach_details_view.dart';
import '../ui/chat/screens/ai_coach_chat.dart';

/// The entry point for the AI Coach SDK.
///
/// Follow these steps to integrate the SDK:
/// 1. Initialize the SDK in your `main()` or before usage:
/// ```dart
/// AiCoach.init(
///   apiKey: 'your_api_key',
///   userId: 'current_user_id',
/// );
/// ```
/// 2. Launch the SDK UI from any context:
/// ```dart
/// AiCoach.launch(context);
/// ```
class AiCoach {
  static AiCoach? _instance;

  final AiCoachRepository repository;
  final AiCoachTheme theme;
  final String userName;

  AiCoach._({
    required this.repository,
    required this.theme,
    required this.userName,
  });

  /// Returns the initialized instance of [AiCoach].
  /// Throws an error if [init] has not been called.
  static AiCoach get instance {
    if (_instance == null) {
      throw StateError(
          'AiCoach SDK is not initialized. Please call AiCoach.init() first.');
    }
    return _instance!;
  }

  /// Initializes the AI Coach SDK with required configuration.
  static void init({
    required String apiKey,
    required String userId,
    String? baseUrl,
    AiCoachTheme theme = const AiCoachTheme(),
    String userName = 'User',
    AiCoachRepository? customRepository,
  }) {
    final config = AiCoachConfig(
      apiKey: apiKey,
      userId: userId,
      baseUrl: baseUrl ?? 'https://aicoachjack.onrender.com',
    );

    _instance = AiCoach._(
      repository: customRepository ?? RemoteAiCoachRepository(config: config),
      theme: theme,
      userName: userName,
    );
  }

  /// Updates the user ID if the user changes in the host application.
  static void updateUserId(String userId) {
    if (_instance != null) {
      // Re-initialize with same settings but new ID
      init(
        apiKey: (instance.repository as RemoteAiCoachRepository).config.apiKey,
        userId: userId,
        baseUrl: (instance.repository as RemoteAiCoachRepository).config.baseUrl,
        theme: instance.theme,
        userName: instance.userName,
      );
    }
  }

  /// Launches the full AI Coach experience starting from the Home View.
  static Future<void> launch(BuildContext context) {
    final i = instance;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachHomeView(
          theme: i.theme,
          userName: i.userName,
          onMyChatsPressed: () => launchChats(context),
          onChooseCoachPressed: () => launchCoachList(context),
        ),
      ),
    );
  }

  /// Launches the chat history view.
  static Future<void> launchChats(BuildContext context) {
    final i = instance;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachChatsView(
          theme: i.theme,
          repository: i.repository,
          onChatTapped: (session) => launchChat(context, session: session),
        ),
      ),
    );
  }

  /// Launches the coach selection view.
  static Future<void> launchCoachList(BuildContext context) {
    final i = instance;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachListView(
          theme: i.theme,
          repository: i.repository,
          onCoachChosen: (coach) => launchChat(context, coachId: coach.id),
          onCoachDetails: (coach) => launchCoachDetails(context, coach),
        ),
      ),
    );
  }

  /// Launches the details view for a specific coach.
  static Future<void> launchCoachDetails(BuildContext context, Coach coach) {
    final i = instance;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachDetailsView(
          coach: coach,
          theme: i.theme,
          onChoosePressed: (selectedCoach) => launchChat(context, coachId: selectedCoach.id),
        ),
      ),
    );
  }

  /// Launches a specific chat session or starts a new one for a coach.
  static Future<void> launchChat(
    BuildContext context, {
    dynamic session,
    String? coachId,
  }) {
    final i = instance;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachChat(
          session: session is String ? null : session,
          coachId: coachId ?? (session is String ? session : null),
          userName: i.userName,
          repository: i.repository,
          theme: i.theme,
        ),
      ),
    );
  }
}
