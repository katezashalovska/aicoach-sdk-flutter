import 'package:flutter/material.dart';
import 'package:ai_coach_jack/ai_coach_jack.dart';

/// A simple service locator to manage the AI Coach SDK dependencies.
/// This follows a clean architecture pattern where configuration is decoupled from the UI.
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final AiCoachRepository _repository;
  late final AiCoachTheme _theme;

  /// Returns the configured repository instance.
  AiCoachRepository get repository => _repository;

  /// Returns the configured theme instance.
  AiCoachTheme get theme => _theme;

  /// Initializes the SDK with the required configuration.
  void setup() {
    // 1. Define the backend configuration
    const config = AiCoachConfig(
      apiKey: 'sk_3a99fd4d0574469fbc1f58ed8f7fa08e_c1b67984746f4b89',
      userId: 'user_123_dan',
    );

    // 2. Define the visual theme
    _theme = AiCoachTheme(
      // Brand Colors
      primaryColor: const Color(0xFF7B61FF),
      onAccentColor: Colors.white,

      // Background & Surface Colors
      backgroundColor: const Color(0xFFFAFAFA),
      cardBackgroundColor: const Color(0xFFF7F7F7),
      cardBorderColor: const Color(0xFFD4D4D4),

      // Text & Asset Colors
      secondaryTextColor: const Color(0xFFAFAFAF),
      placeholderColor: const Color(0xFFEEEEEE),

      // Tag & Interaction Colors
      tagBackgroundColor: const Color(0x66000000),

      // Global Layout
      buttonRadius: 12.0,
    );

    // 3. Choose the repository implementation
    _repository = RemoteAiCoachRepository(config: config);
  }
}

// Global instance for easy access
final locator = ServiceLocator();
