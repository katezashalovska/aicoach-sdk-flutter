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
}
