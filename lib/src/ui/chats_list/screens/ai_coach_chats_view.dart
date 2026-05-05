import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/chat_item.dart';
import '../../../repository/ai_coach_repository.dart';
import '../widgets/chat_list_item.dart';
import '../../shared/ai_coach_app_bar.dart';

class AiCoachChatsView extends StatelessWidget {
  final AiCoachTheme theme;
  final AiCoachRepository repository;

  /// Callback when a specific chat is tapped.
  /// Passes the full ChatItem to the host application to handle navigation.
  final void Function(ChatItem coach) onChatTapped;

  const AiCoachChatsView({
    super.key,
    this.theme = const AiCoachTheme(),
    required this.repository,
    required this.onChatTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: 'My chats',
        theme: theme,
      ),
      body: FutureBuilder<List<ChatItem>>(
        future: repository.getChatSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading chats: ${snapshot.error}',
                style: theme.bodyStyle,
              ),
            );
          }

          final chats = snapshot.data ?? [];
          
          // Sort chats by most recent message
          chats.sort((a, b) {
            if (a.lastMessageAt == null && b.lastMessageAt == null) return 0;
            if (a.lastMessageAt == null) return 1;
            if (b.lastMessageAt == null) return -1;
            return b.lastMessageAt!.compareTo(a.lastMessageAt!);
          });

          if (chats.isEmpty) {
            return Center(
              child: Text(
                'No active chats yet.',
                style: theme.bodyStyle,
              ),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ChatListItem(
                chat: chat,
                theme: theme,
                onTap: () => onChatTapped(chat),
              );
            },
          );
        },
      ),
    );
  }
}
