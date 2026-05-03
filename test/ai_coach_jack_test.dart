import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ai_coach_jack/ai_coach_jack.dart';

void main() {
  test('AiCoachTheme has default colors', () {
    const theme = AiCoachTheme();
    expect(theme.primaryColor, const Color(0xFF7B61FF));
    expect(theme.backgroundColor, const Color(0xFFFAFAFA));
  });
}
