import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/chat_message.dart';
import '../../../models/chat_item.dart';
import '../../../repository/ai_coach_repository.dart';
import '../../shared/ai_coach_app_bar.dart';
import '../controllers/ai_coach_chat_controller.dart';
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
  late final AiCoachChatController _controller;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AiCoachChatController(
      repository: widget.repository,
      coachId: widget.coachId,
      initialSession: widget.session,
    );
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    // Automatically scroll to bottom when new messages arrive or grow
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: widget.theme.backgroundColor,
          appBar: AiCoachAppBar(
            title: _controller.currentSession?.name ?? 'Chat',
            theme: widget.theme,
          ),
          body: Column(
            children: [
              Expanded(
                child: _controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                        controller: _scrollController,
                        reverse: true,
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final bool showTyping = _controller.isSending &&
                                      (_controller.messages.isEmpty ||
                                          _controller.messages.last.isUser);
                                  if (showTyping && index == 0) {
                                    return _buildTypingIndicator();
                                  }

                                  final messageIndex = showTyping ? index - 1 : index;
                                  if (messageIndex < 0 ||
                                      messageIndex >= _controller.messages.length) {
                                    return null;
                                  }

                                  return ChatMessageBubble(
                                    message: _controller.messages[
                                        _controller.messages.length - 1 - messageIndex],
                                    theme: widget.theme,
                                  );
                                },
                                childCount: _controller.messages.length +
                                    (_controller.isSending &&
                                            (_controller.messages.isEmpty ||
                                                _controller.messages.last.isUser)
                                        ? 1
                                        : 0),
                              ),
                            ),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  ChatGreeting(
                                    userName: widget.userName,
                                    session: _controller.currentSession,
                                    theme: widget.theme,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              ChatInput(
                controller: _textController,
                isSending: _controller.isSending,
                theme: widget.theme,
                onSend: () {
                  final text = _textController.text;
                  if (text.trim().isNotEmpty) {
                    _textController.clear();
                    _controller.sendMessage(text);
                  }
                },
              ),
            ],
          ),
        );
      },
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
