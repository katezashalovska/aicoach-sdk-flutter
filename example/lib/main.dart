import 'package:flutter/material.dart';
import 'package:ai_coach_jack/ai_coach_jack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Coach Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AiCoachView(
        apiKey: 'demo_api_key_123',
        userId: 'user_001',
      ),
    );
  }
}
