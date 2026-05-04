import 'dart:async';
import 'package:flutter/material.dart';
import '../../../models/chat_item.dart';
import '../../../models/chat_message.dart';
import '../../../repository/ai_coach_repository.dart';

/// Controller that handles the business logic for the AI Coach Chat.
/// Separates the state management and network logic from the UI layer.
class AiCoachChatController extends ChangeNotifier {
  final AiCoachRepository repository;
  final String? coachId;
  final ChatItem? initialSession;

  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  ChatItem? _currentSession;
  String? _error;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  ChatItem? get currentSession => _currentSession;
  String? get error => _error;

  AiCoachChatController({
    required this.repository,
    this.coachId,
    this.initialSession,
  }) {
    _currentSession = initialSession;
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      if (_currentSession == null && coachId != null) {
        final existingSessions = await repository.getChatSessions();
        final match = existingSessions.firstWhere(
          (s) => s.coachId == coachId,
          orElse: () =>
              const ChatItem(id: '', coachId: '', name: '', avatarUrl: ''),
        );

        if (match.id.isNotEmpty) {
          _currentSession = match;
        } else {
          _currentSession = await repository.createChatSession(coachId!);
        }
        notifyListeners();
      }

      if (_currentSession != null) {
        final history = await repository.getSessionHistory(_currentSession!.id);
        _messages = history;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to initialize chat: $e';
      notifyListeners();
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _isSending || _currentSession == null) return;

    _isSending = true;
    _messages.add(
      ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    try {
      int? aiMessageIndex;
      String accumulatedText = '';

      final stream = repository.streamMessage(_currentSession!.id, text);

      await for (final chunk in stream) {
        if (accumulatedText.isEmpty && chunk.isNotEmpty) {
          // First chunk arrived! Add the AI message bubble
          final aiMessage = ChatMessage(
            text: '',
            isUser: false,
            timestamp: DateTime.now(),
          );
          _messages.add(aiMessage);
          aiMessageIndex = _messages.length - 1;
        }

        accumulatedText += chunk;
        if (aiMessageIndex != null) {
          _messages[aiMessageIndex] =
              _messages[aiMessageIndex].copyWith(text: accumulatedText);
          notifyListeners();
        }
      }

      _isSending = false;
      notifyListeners();
    } catch (e) {
      _isSending = false;
      // If we added an empty AI message, remove it
      if (_messages.isNotEmpty &&
          !_messages.last.isUser &&
          _messages.last.text.isEmpty) {
        _messages.removeLast();
      }
      
      _messages.add(
        ChatMessage(
          text: 'Sorry, I couldn\'t reach the server. Please try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }
}
