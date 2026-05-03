import 'package:flutter/material.dart';
import 'package:ai_coach_jack/ai_coach_jack.dart';
import 'service_locator.dart';

void main() {
  // 1. Initialize dependencies in a decoupled way
  locator.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Coach Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B61FF)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const HostAppHomeScreen(),
    );
  }
}

class HostAppHomeScreen extends StatelessWidget {
  const HostAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Fitness App'),
        backgroundColor: const Color(0xFF7B61FF),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center,
                size: 64, color: Color(0xFF7B61FF)),
            const SizedBox(height: 24),
            Text(
              'Welcome back, Jonatan!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                AiCoach.launch(
                  context,
                  repository: locator.repository,
                  theme: locator.theme,
                  userName: 'Dan',
                );
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Chat with AI Coach'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B61FF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
