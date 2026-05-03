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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // This simulates the user tapping a button in their app to launch your SDK
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AiCoachHomeView(
                  // The host app can pass a custom theme here, we use defaults now
                  theme: const AiCoachTheme(),
                  onMyChatsPressed: () {
                    // Navigate to the list of chats
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AiCoachChatsView(
                          onChatTapped: (coach) {
                            // Here the host app would navigate to the actual chat room
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AiCoachView(
                                  coach: coach,
                                  userName: 'Jonatan', // Passed from the host app's user profile
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  onChooseCoachPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AiCoachListView(
                          onCoachChosen: (coach) {
                            // Navigate to the chat view with the selected coach
                            // In a real app, you might create a chat in the DB first
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AiCoachView(
                                  coach: ChatItem(
                                    id: coach.id,
                                    name: coach.name,
                                    avatarUrl: coach.imageUrl,
                                  ),
                                  userName: 'Jonatan',
                                ),
                              ),
                            );
                          },
                          onCoachDetails: (coach) {
                            debugPrint('Details for ${coach.name}');
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          icon: const Icon(Icons.fitness_center),
          label: const Text('Open AI Coach'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
