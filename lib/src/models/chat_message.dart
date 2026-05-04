/// Represents a single message within a chat conversation.
class ChatMessage {
  /// The text content of the message.
  final String text;

  /// True if the message was sent by the user, false if sent by the AI coach.
  final bool isUser;

  /// The time the message was sent.
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['content'] ?? '',
      isUser: json['sender']?.toString().toUpperCase() == 'USER',
      timestamp: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
