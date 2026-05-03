import 'package:flutter/material.dart';
import 'ai_coach_text_styles.dart';

/// Configuration class for the AI Coach SDK Theme.
/// This allows host applications to override the colors and text styles
/// to match their own branding.
class AiCoachTheme {
  /// The primary brand color used for main buttons and icons.
  final Color primaryColor;

  /// Background color of the screens.
  final Color backgroundColor;

  /// Background color of cards/list items.
  final Color cardBackgroundColor;

  /// Border color for cards/list items.
  final Color cardBorderColor;

  /// Color for secondary text (e.g. descriptions, last messages).
  final Color secondaryTextColor;

  /// Color for text/icons on top of primary color.
  final Color onPrimaryColor;

  /// Background color for skill tags.
  final Color tagBackgroundColor;

  /// Text color for skill tags.
  final Color tagTextColor;

  /// Color for image placeholders.
  final Color placeholderColor;

  /// Border radius used for buttons and cards.
  final double buttonRadius;

  /// Text style for app bar titles.
  final TextStyle titleStyle;

  /// Text style for main headings.
  final TextStyle headingStyle;

  /// Text style for smaller headings (e.g. My chats).
  final TextStyle subTitleStyle;

  /// Text style for body text and descriptions.
  final TextStyle bodyStyle;

  /// Text style for main buttons.
  final TextStyle buttonStyle;

  /// Text style for secondary buttons (e.g. See details).
  final TextStyle secondaryButtonStyle;

  const AiCoachTheme({
    this.primaryColor = const Color(0xFF7B61FF),
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.cardBackgroundColor = const Color(0xFFF7F7F7),
    this.cardBorderColor = const Color(0xFFD4D4D4),
    this.secondaryTextColor = const Color(0xFFAFAFAF),
    this.onPrimaryColor = Colors.white,
    this.tagBackgroundColor = const Color(0x66000000), // Black with opacity
    this.tagTextColor = Colors.white,
    this.placeholderColor = const Color(0xFFEEEEEE),
    this.buttonRadius = 8.0,
    this.titleStyle = AiCoachTextStyles.headerLarge,
    this.headingStyle = AiCoachTextStyles.headerLarge,
    this.subTitleStyle = AiCoachTextStyles.headerSmall,
    this.bodyStyle = AiCoachTextStyles.body,
    this.buttonStyle = AiCoachTextStyles.button,
    this.secondaryButtonStyle = AiCoachTextStyles.headerSmall,
  });
}
