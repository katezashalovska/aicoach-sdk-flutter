import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/ai_coach_theme.dart';
import '../models/chat_message.dart';
import '../models/chat_item.dart';
import 'widgets/chat_message_bubble.dart';
import 'widgets/ai_coach_app_bar.dart';

/// The main view for the AI Coach SDK chat room.
class AiCoachView extends StatefulWidget {
  /// The coach data
  final ChatItem coach;

  /// The current user's name to display in the greeting
  final String userName;

  /// The theme configuration for styling
  final AiCoachTheme theme;

  const AiCoachView({
    Key? key,
    required this.coach,
    required this.userName,
    this.theme = const AiCoachTheme(),
  }) : super(key: key);

  @override
  State<AiCoachView> createState() => _AiCoachViewState();
}

class _AiCoachViewState extends State<AiCoachView> {
  final TextEditingController _textController = TextEditingController();

  // Starts completely empty as per the design
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    final text = _textController.text;
    _textController.clear();

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );

      // Dismiss the keyboard
      FocusScope.of(context).unfocus();

      // Mock AI response
      _messages.add(
        ChatMessage(
          text: 'Let me help you with that.',
          isUser: false,
          timestamp: DateTime.now().add(const Duration(seconds: 1)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: widget.coach.name,
        theme: widget.theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 24.0,
                bottom: 0.0,
              ),
              // We add 1 to length to show the static intro header at the very top
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Intro header
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0), // Reduced from 32.0 to match message spacing
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Coach Avatar with purple border
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: widget.theme.primaryColor, width: 2),
                            image: widget.coach.avatarUrl.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                      widget.coach.avatarUrl.startsWith('http')
                                          ? widget.coach.avatarUrl
                                          : 'https://i.pravatar.cc/150?u=${widget.coach.id}',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: widget.coach.avatarUrl.isEmpty
                              ? Icon(Icons.person,
                                  size: 40, color: widget.theme.secondaryTextColor)
                              : null,
                        ),
                        const SizedBox(width: 16),

                        // Greeting and description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, ${widget.userName}!',
                                style: widget.theme.headingStyle,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Write what interests you and I will be happy to give you an answer so that you can achieve your goal',
                                style: widget.theme.bodyStyle.copyWith(
                                  color: widget.theme.secondaryTextColor, // Lighter gray text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Chat bubbles
                return ChatMessageBubble(
                  message: _messages[index - 1],
                  theme: widget.theme,
                );
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 32.0, top: 0.0),
            color: widget.theme.backgroundColor, // No top border
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52, // Fixed height to match button
                    child: TextField(
                      controller: _textController,
                      style: widget.theme.bodyStyle,
                      decoration: InputDecoration(
                        hintText: 'Enter your question',
                        hintStyle: widget.theme.bodyStyle
                            .copyWith(color: widget.theme.secondaryTextColor),
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(widget.theme.buttonRadius),
                          borderSide:
                              BorderSide(color: widget.theme.cardBorderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(widget.theme.buttonRadius),
                          borderSide:
                              BorderSide(color: widget.theme.cardBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(widget.theme.buttonRadius),
                          borderSide:
                              BorderSide(color: widget.theme.primaryColor),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                // Send button matching the design
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: widget.theme.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(widget.theme.buttonRadius),
                    border: Border.all(
                      color: widget.theme.primaryColor, // Made solid color
                      width: 1.5, // Bolder border
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_send.svg',
                      package:
                          'ai_coach_jack', // CRITICAL: Must provide package name
                      colorFilter: ColorFilter.mode(
                        widget.theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                      width: 28, // Bigger icon
                      height: 28, // Bigger icon
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
