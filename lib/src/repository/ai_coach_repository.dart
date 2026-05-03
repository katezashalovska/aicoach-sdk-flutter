import '../models/coach.dart';
import '../models/chat_item.dart';
import '../models/chat_message.dart';

/// Abstract repository defining the data operations for the AI Coach SDK.
/// This allows the SDK to switch between mock data and real backend implementation.
abstract class AiCoachRepository {
  /// Fetches the list of all active coaches.
  Future<List<Coach>> getCoaches();

  /// Fetches a single coach by their ID.
  Future<Coach> getCoachById(String id);

  /// Fetches all chat sessions for the current user.
  Future<List<ChatItem>> getChatSessions();

  /// Creates a new chat session with a specific coach.
  Future<ChatItem> createChatSession(String coachId);

  /// Fetches the message history for a specific session.
  Future<List<ChatMessage>> getSessionHistory(String sessionId);

  /// Sends a message and receives the complete AI response.
  Future<ChatMessage> sendMessage(String sessionId, String content, {String? photoUrl});

  /// Sends a message and receives the AI response as a stream of events (SSE).
  Stream<String> streamMessage(String sessionId, String content, {String? photoUrl});
}
