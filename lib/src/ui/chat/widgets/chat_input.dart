import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/ai_coach_theme.dart';

/// The input area at the bottom of the chat screen.
class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final AiCoachTheme theme;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.isSending,
    required this.theme,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 32.0, top: 0.0),
      color: theme.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: TextField(
                controller: controller,
                style: theme.bodyStyle,
                enabled: !isSending,
                decoration: InputDecoration(
                  hintText: 'Enter your question',
                  hintStyle: theme.bodyStyle
                      .copyWith(color: theme.secondaryTextColor),
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 0.0),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(theme.buttonRadius),
                    borderSide:
                        BorderSide(color: theme.cardBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(theme.buttonRadius),
                    borderSide:
                        BorderSide(color: theme.cardBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(theme.buttonRadius),
                    borderSide:
                        BorderSide(color: theme.primaryColor),
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.08),
              borderRadius:
                  BorderRadius.circular(theme.buttonRadius),
              border: Border.all(
                color: theme.primaryColor,
                width: 1.5,
              ),
            ),
            child: isSending
                ? const Center(
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2)))
                : IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_send.svg',
                      package: 'aicoach_sdk_flutter',
                      colorFilter: ColorFilter.mode(
                        theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                      width: 28,
                      height: 28,
                    ),
                    onPressed: onSend,
                  ),
          ),
        ],
      ),
    );
  }
}
