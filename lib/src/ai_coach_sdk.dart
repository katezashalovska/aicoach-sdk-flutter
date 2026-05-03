import 'package:flutter/material.dart';
import 'package:ai_coach_jack/src/repository/ai_coach_repository.dart';
import 'package:ai_coach_jack/src/theme/ai_coach_theme.dart';
import 'package:ai_coach_jack/src/ui/home/screens/ai_coach_home_view.dart';
import 'package:ai_coach_jack/src/ui/coach_list/screens/ai_coach_list_view.dart';
import 'package:ai_coach_jack/src/ui/chats_list/screens/ai_coach_chats_view.dart';
import 'package:ai_coach_jack/src/ui/chat/screens/ai_coach_chat.dart';
import 'package:ai_coach_jack/src/ui/coach_details/screens/ai_coach_details_view.dart';

/// The entry point for the AI Coach SDK.
/// Use this class to launch the SDK UI with a single call.
class AiCoach {
  /// Launches the full AI Coach experience starting from the Home View.
  static Future<void> launch(
    BuildContext context, {
    required AiCoachRepository repository,
    AiCoachTheme theme = const AiCoachTheme(),
    String userName = 'User',
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachHomeView(
          theme: theme,
          userName: userName,
          onMyChatsPressed: () => launchChats(context,
              repository: repository, theme: theme, userName: userName),
          onChooseCoachPressed: () => launchCoachList(context,
              repository: repository, theme: theme, userName: userName),
        ),
      ),
    );
  }

  /// Launches the chat history view.
  static Future<void> launchChats(
    BuildContext context, {
    required AiCoachRepository repository,
    AiCoachTheme theme = const AiCoachTheme(),
    String userName = 'User',
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachChatsView(
          theme: theme,
          repository: repository,
          onChatTapped: (session) => launchChat(context,
              repository: repository,
              theme: theme,
              userName: userName,
              session: session),
        ),
      ),
    );
  }

  /// Launches the coach selection view.
  static Future<void> launchCoachList(
    BuildContext context, {
    required AiCoachRepository repository,
    AiCoachTheme theme = const AiCoachTheme(),
    String userName = 'User',
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachListView(
          theme: theme,
          repository: repository,
          onCoachChosen: (coach) => launchChat(context,
              repository: repository,
              theme: theme,
              userName: userName,
              coachId: coach.id),
          onCoachDetails: (coach) {
            // Optional: Implement details view navigation here if needed
          },
        ),
      ),
    );
  }

  /// Launches a specific chat session or starts a new one for a coach.
  static Future<void> launchChat(
    BuildContext context, {
    required AiCoachRepository repository,
    AiCoachTheme theme = const AiCoachTheme(),
    String userName = 'User',
    dynamic session,
    String? coachId,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiCoachChat(
          session: session is String ? null : session,
          coachId: coachId ?? (session is String ? session : null),
          userName: userName,
          repository: repository,
          theme: theme,
        ),
      ),
    );
  }
}
