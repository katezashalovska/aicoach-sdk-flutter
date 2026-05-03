import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/chat_item.dart';

/// The greeting header shown at the very top of a new conversation.
class ChatGreeting extends StatelessWidget {
  final String userName;
  final ChatItem? session;
  final AiCoachTheme theme;

  const ChatGreeting({
    super.key,
    required this.userName,
    this.session,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.primaryColor, width: 2),
              image: session?.avatarUrl != null && session!.avatarUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        session!.avatarUrl.startsWith('http')
                            ? session!.avatarUrl
                            : 'https://i.pravatar.cc/150?u=${session!.id}',
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: session?.avatarUrl == null || session!.avatarUrl.isEmpty
                ? Icon(Icons.person,
                    size: 40, color: theme.secondaryTextColor)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $userName!',
                  style: theme.headingStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  'Write what interests you and I will be happy to give you an answer so that you can achieve your goal',
                  style: theme.bodyStyle.copyWith(
                    color: theme.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
