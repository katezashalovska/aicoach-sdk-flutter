/// Represents a single chat conversation in the AI Coach SDK.
class ChatItem {
  /// Unique identifier for the chat (session ID)
  final String id;

  /// The ID of the coach associated with this chat
  final String coachId;

  /// The name of the coach or user
  final String name;

  /// URL or asset path for the avatar image
  final String avatarUrl;

  /// The most recent message in the conversation
  final String lastMessage;

  /// Whether there are unread messages
  final bool hasUnread;

  /// The time the most recent message was sent
  final DateTime? lastMessageAt;

  const ChatItem({
    required this.id,
    required this.coachId,
    required this.name,
    required this.avatarUrl,
    this.lastMessage = '',
    this.hasUnread = false,
    this.lastMessageAt,
  });

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json['id'] ?? '',
      coachId: json['coachId'] ?? '',
      name: json['coachName'] ?? '',
      avatarUrl: json['coachPhotoUrl'] ?? '', 
      lastMessage: json['lastMessagePreview'] ?? '',
      hasUnread: false,
      lastMessageAt: json['lastMessageAt'] != null 
          ? DateTime.parse(json['lastMessageAt']) 
          : null,
    );
  }
}
