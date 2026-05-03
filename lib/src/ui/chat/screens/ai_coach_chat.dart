import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/chat_message.dart';
import '../../../models/chat_item.dart';
import '../../../repository/ai_coach_repository.dart';
import '../../shared/ai_coach_app_bar.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/chat_greeting.dart';
import '../widgets/chat_input.dart';
import '../widgets/chat_message_bubble.dart';

/// The main view for the AI Coach SDK chat room.
class AiCoachChat extends StatefulWidget {
  /// The existing chat session (if any)
  final ChatItem? session;

  /// The coach ID to start a new session with (if session is null)
  final String? coachId;

  /// The current user's name to display in the greeting
  final String userName;

  /// The theme configuration for styling
  final AiCoachTheme theme;

  /// The repository for chat operations
  final AiCoachRepository repository;

  const AiCoachChat({
    super.key,
    this.session,
    this.coachId,
    required this.userName,
    required this.repository,
    this.theme = const AiCoachTheme(),
  })  : assert(session != null || coachId != null,
            'Either session or coachId must be provided');

  @override
  State<AiCoachChat> createState() => _AiCoachChatState();
}

class _AiCoachChatState extends State<AiCoachChat> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  ChatItem? _currentSession;

  @override
  void initState() {
    super.initState();
    _currentSession = widget.session;
    _initializeChat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    try {
      if (_currentSession == null && widget.coachId != null) {
        final existingSessions = await widget.repository.getChatSessions();
        final match = existingSessions.firstWhere(
          (s) => s.coachId == widget.coachId,
          orElse: () => const ChatItem(id: '', coachId: '', name: '', avatarUrl: ''),
        );

        if (match.id.isNotEmpty) {
          _currentSession = match;
        } else {
          _currentSession = await widget.repository.createChatSession(widget.coachId!);
        }
      }

      if (_currentSession != null) {
        final history = await widget.repository.getSessionHistory(_currentSession!.id);
        if (mounted) {
          setState(() {
            _messages.addAll(history);
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _sendMessage() async {
    if (_textController.text.trim().isEmpty || _isSending || _currentSession == null) return;

    final text = _textController.text;
    _textController.clear();

    setState(() {
      _isSending = true;
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    FocusScope.of(context).unfocus();

    try {
      final response = await widget.repository.sendMessage(_currentSession!.id, text);
      if (mounted) {
        setState(() {
          _messages.add(response);
          _isSending = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSending = false;
          _messages.add(
            ChatMessage(
              text: 'Sorry, I couldn\'t reach the server. Please try again.',
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: _currentSession?.name ?? 'Chat',
        theme: widget.theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 0.0,
                      bottom: 24.0,
                    ),
                    itemCount: _messages.length + 1 + (_isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isSending && index == 0) {
                        return _buildTypingIndicator();
                      }

                      final messageIndex = _isSending ? index - 1 : index;

                      if (messageIndex == _messages.length) {
                        return ChatGreeting(
                          userName: widget.userName,
                          session: _currentSession,
                          theme: widget.theme,
                        );
                      }

                      return ChatMessageBubble(
                        message: _messages[_messages.length - 1 - messageIndex],
                        theme: widget.theme,
                      );
                    },
                  ),
          ),
          ChatInput(
            controller: _textController,
            isSending: _isSending,
            theme: widget.theme,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.theme.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.theme.primaryColor),
            ),
            child: TypingIndicator(color: widget.theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
