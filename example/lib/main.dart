import 'package:flutter/material.dart';
import 'package:aicoach_sdk_flutter/aicoach_sdk_flutter.dart';

void main() {
  // Initialize AI Coach SDK
  AiCoach.init(
    apiKey: 'YOUR_API_KEY',
    userId: 'unique_user_id',
    userName: 'Jane',
    theme: AiCoachTheme(
      primaryColor: const Color(0xFF7B61FF),
      onAccentColor: Colors.white,
    ),
  );

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fitness_center,
                  size: 64, color: Color(0xFF7B61FF)),
              const SizedBox(height: 24),
              Text(
                'Welcome back, Jane!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              const Text(
                'How would you like to train today?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              
              // Button 1: Main AI Coach Entry (Default)
              _buildMenuButton(
                context,
                icon: Icons.auto_awesome,
                label: 'Global AI Coach',
                subtitle: 'Get instant help from our AI',
                onTap: () => AiCoach.launch(context),
              ),
              
              const SizedBox(height: 16),
              
              // Button 2: My Chats
              _buildMenuButton(
                context,
                icon: Icons.chat_bubble_outline,
                label: 'My Chat Sessions',
                subtitle: 'Continue your conversations',
                onTap: () => AiCoach.launchChats(context),
              ),
              
              const SizedBox(height: 16),
              
              // Button 3: Choose Coach
              _buildMenuButton(
                context,
                icon: Icons.people_outline,
                label: 'Choose a Coach',
                subtitle: 'Find the perfect mentor for you',
                onTap: () => AiCoach.launchCoachList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF7B61FF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF7B61FF)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
