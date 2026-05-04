import 'dart:async';
import 'dart:convert';
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
    try {
      final response = await _dio.post(
        '/v1/chat/sessions/$sessionId/stream',
        data: {
          'content': content,
          'photoUrl': photoUrl,
        },
        options: Options(responseType: ResponseType.stream),
      );

      final responseStream = response.data.stream as Stream;
      String buffer = '';

      // Use a timeout to close the stream if the server hangs after sending the response
      final timedStream = responseStream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .timeout(const Duration(seconds: 2), onTimeout: (sink) {
        sink.close();
      });

      await for (final chunk in timedStream) {
        buffer += chunk;

        // SSE events are separated by double newlines
        while (buffer.contains('\n\n')) {
          final index = buffer.indexOf('\n\n');
          final event = buffer.substring(0, index);
          buffer = buffer.substring(index + 2);

          yield* _parseSseEvent(event);
        }
      }

      // Handle any remaining data in the buffer after the stream closes
      if (buffer.isNotEmpty) {
        yield* _parseSseEvent(buffer);
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<String> _parseSseEvent(String event) async* {
    final lines = event.split('\n');
    List<String> dataParts = [];

    for (var line in lines) {
      if (line.startsWith('data:')) {
        // Strip 'data:' prefix
        String content = line.substring(5);
        // Strip leading space if present
        if (content.startsWith(' ')) {
          content = content.substring(1);
        }
        dataParts.add(content);
      } else if (line.isNotEmpty && !line.startsWith(':')) {
        dataParts.add(line);
      }
    }

    if (dataParts.isNotEmpty) {
      final dataBuffer = dataParts.join('\n');
      final trimmedData = dataBuffer.trim();

      if (trimmedData == '[DONE]') {
        return;
      }

      try {
        final decoded = jsonDecode(dataBuffer);
        final String text = decoded['text'] ??
            decoded['content'] ??
            decoded['delta']?['content'] ??
            '';
        if (text.isNotEmpty) {
          yield text;
        } else if (decoded is String) {
          yield decoded;
        }
      } catch (e) {
        yield dataBuffer;
      }
    }
  }
}
