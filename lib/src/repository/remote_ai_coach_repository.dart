import 'package:dio/dio.dart';
import '../models/coach.dart';
import '../models/chat_item.dart';
import '../models/chat_message.dart';
import '../models/ai_coach_config.dart';
import 'ai_coach_repository.dart';

/// Implementation of AiCoachRepository that connects to the real AI Coach Backend.
class RemoteAiCoachRepository implements AiCoachRepository {
  final Dio _dio;
  final AiCoachConfig config;

  RemoteAiCoachRepository({required this.config})
      : _dio = Dio(BaseOptions(
          baseUrl: config.baseUrl,
          headers: {
            'X-API-Key': config.apiKey,
            'X-User-Id': config.userId,
            'Content-Type': 'application/json',
          },
        ));

  @override
  Future<List<Coach>> getCoaches() async {
    try {
      final response = await _dio.get('/v1/coaches');
      return (response.data as List).map((c) => Coach.fromJson(c)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Coach> getCoachById(String id) async {
    try {
      final response = await _dio.get('/v1/coaches/$id');
      return Coach.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatItem>> getChatSessions() async {
    try {
      // 1. Fetch coaches to get their photos
      final coachesResponse = await _dio.get('/v1/coaches');
      final coaches = (coachesResponse.data as List)
          .map((c) => Coach.fromJson(c))
          .toList();

      // 2. Fetch sessions
      final response = await _dio.get('/v1/chat/sessions');
      final sessionsData = response.data as List;

      return sessionsData.map((s) {
        final chat = ChatItem.fromJson(s);
        // Find the coach's photo
        final coach = coaches.firstWhere(
          (c) => c.id == chat.coachId,
          orElse: () => const Coach(id: '', name: '', imageUrl: '', rating: 0, userCount: '', tags: []),
        );
        
        // Return a copy with the photo
        return ChatItem(
          id: chat.id,
          coachId: chat.coachId,
          name: chat.name,
          avatarUrl: coach.imageUrl,
          lastMessage: chat.lastMessage,
          hasUnread: chat.hasUnread,
          lastMessageAt: chat.lastMessageAt,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatItem> createChatSession(String coachId) async {
    try {
      final response =
          await _dio.post('/v1/chat/sessions', data: {'coachId': coachId});
      return ChatItem.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatMessage>> getSessionHistory(String sessionId) async {
    try {
      final response = await _dio.get('/v1/chat/sessions/$sessionId/messages');
      return (response.data as List)
          .map((m) => ChatMessage.fromJson(m))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatMessage> sendMessage(String sessionId, String content,
      {String? photoUrl}) async {
    try {
      final response = await _dio.post(
        '/v1/chat/sessions/$sessionId/messages',
        data: {'content': content, 'photoUrl': photoUrl},
      );
      return ChatMessage.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<String> streamMessage(String sessionId, String content,
      {String? photoUrl}) async* {
    // SSE Streaming implementation for real-time responses
    // Note: For production, a specialized SSE parser like 'fetch_client' or custom stream parser is needed
    yield "SSE Streaming requested for: $content";
  }
}
