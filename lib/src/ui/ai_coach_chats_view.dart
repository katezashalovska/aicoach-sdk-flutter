import 'package:flutter/material.dart';
import '../theme/ai_coach_theme.dart';
import '../models/chat_item.dart';
import '../data/mock_ai_coach_data.dart';
import 'widgets/chat_list_item.dart';
import 'widgets/ai_coach_app_bar.dart';

class AiCoachChatsView extends StatefulWidget {
  final AiCoachTheme theme;

  /// Callback when a specific chat is tapped.
  /// Passes the full ChatItem to the host application to handle navigation.
  final void Function(ChatItem coach) onChatTapped;

  const AiCoachChatsView({
    Key? key,
    this.theme = const AiCoachTheme(),
    required this.onChatTapped,
  }) : super(key: key);

  @override
  State<AiCoachChatsView> createState() => _AiCoachChatsViewState();
}

class _AiCoachChatsViewState extends State<AiCoachChatsView> {
  final List<ChatItem> _chats = MockAiCoachData.chats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: 'My chats',
        theme: widget.theme,
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ChatListItem(
            chat: chat,
            theme: widget.theme,
            onTap: () => widget.onChatTapped(chat),
          );
        },
      ),
    );
  }
}
