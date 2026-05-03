import 'package:flutter/material.dart';
import '../../theme/ai_coach_theme.dart';
import '../../models/chat_item.dart';

/// A widget representing a single chat item row in the list.
class ChatListItem extends StatelessWidget {
  final ChatItem chat;
  final AiCoachTheme theme;
  final VoidCallback onTap;

  const ChatListItem({
    Key? key,
    required this.chat,
    required this.theme,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          border: Border(
            bottom: BorderSide(color: theme.cardBorderColor, width: 1.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.placeholderColor,
                image: chat.avatarUrl.isNotEmpty
                    ? DecorationImage(
                        // For this hardcoded example we'll assume it's a network image,
                        // but you could use NetworkImage or AssetImage based on your setup.
                        // We use a dummy image if avatarUrl is a placeholder text.
                        image: NetworkImage(
                          chat.avatarUrl.startsWith('http') 
                              ? chat.avatarUrl 
                              : 'https://i.pravatar.cc/150?u=${chat.id}',
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Unread indicator dot
                      if (chat.hasUnread) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      
                      // Name
                      Expanded(
                        child: Text(
                          chat.name,
                          style: theme.subTitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Last message
                  Text(
                    chat.lastMessage,
                    style: theme.bodyStyle.copyWith(
                      color: theme.secondaryTextColor, // Lighter gray as per design
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
