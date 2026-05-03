import 'package:flutter/material.dart';

/// Predefined text styles for the AI Coach SDK
class AiCoachTextStyles {
  /// The main font family used across the SDK
  static const String fontFamily = 'Inter';

  /// The default dark grey text color.
  static const Color defaultTextColor = Color(0xFF403F3F);

  /// Used for major headers such as 'Chat with coach' and 'Ask the coach'
  static const TextStyle headerLarge = TextStyle(
    color: defaultTextColor,
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  /// Used for smaller headers such as 'My chats'
  static const TextStyle headerSmall = TextStyle(
    color: defaultTextColor,
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Used for ordinary paragraph text
  static const TextStyle body = TextStyle(
    color: defaultTextColor,
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// Used for text inside buttons
  static const TextStyle button = TextStyle(
    color: Color(0xFFFAFAFA),
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
