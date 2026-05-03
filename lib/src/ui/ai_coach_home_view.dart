import 'package:flutter/material.dart';
import '../theme/ai_coach_theme.dart';
import 'widgets/ai_coach_app_bar.dart';

class AiCoachHomeView extends StatelessWidget {
  /// Theme configuration to allow host apps to customize the UI.
  final AiCoachTheme theme;

  /// Callback when "My chats" is pressed.
  final VoidCallback onMyChatsPressed;

  /// Callback when "Choose coach" is pressed.
  final VoidCallback onChooseCoachPressed;

  const AiCoachHomeView({
    Key? key,
    this.theme = const AiCoachTheme(),
    required this.onMyChatsPressed,
    required this.onChooseCoachPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: 'Chat with coach',
        theme: theme,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // My chats button
            Material(
              color: theme.cardBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(theme.buttonRadius),
                side: BorderSide(color: theme.cardBorderColor),
              ),
              child: InkWell(
                onTap: onMyChatsPressed,
                borderRadius: BorderRadius.circular(theme.buttonRadius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: theme.primaryColor,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'My chats',
                          style: theme.subTitleStyle,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: theme.titleStyle.color,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Ask the coach Title
            Text(
              'Ask the coach',
              style: theme.headingStyle,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              'You can ask your questions to one of our coach at any time, it will help you and give you the advice you need.',
              style: theme.bodyStyle,
            ),
            const SizedBox(height: 24),

            // Choose coach button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onChooseCoachPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.onPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(theme.buttonRadius),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Choose coach',
                  style: theme.buttonStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
