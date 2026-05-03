/// Represents a single chat conversation in the AI Coach SDK.
class ChatItem {
  /// Unique identifier for the chat
  final String id;

  /// The name of the coach or user
  final String name;

  /// URL or asset path for the avatar image
  final String avatarUrl;

  /// The most recent message in the conversation
  final String lastMessage;

  /// Whether there are unread messages
  final bool hasUnread;

  const ChatItem({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.lastMessage = '',
    this.hasUnread = false,
  });
}
