import 'package:flutter/material.dart';

/// The main view for the AI Coach SDK.
/// Embed this widget into your app to provide the AI coach experience.
class AiCoachView extends StatefulWidget {
  /// Your SDK API key
  final String apiKey;
  
  /// The current user's ID
  final String userId;

  const AiCoachView({
    Key? key,
    required this.apiKey,
    required this.userId,
  }) : super(key: key);

  @override
  State<AiCoachView> createState() => _AiCoachViewState();
}

class _AiCoachViewState extends State<AiCoachView> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [
    'Coach: Hi! I am Jack, your AI Coach. How can I help you today?',
  ];

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add('User: ${_textController.text}');
      // Mock AI response
      _messages.add('Coach: Keep up the great work! Let me analyze that for you.');
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // We use a Scaffold here, but in a real SDK you might want to make it
    // flexible so the host app can provide the Scaffold, or offer both options.
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Coach Jack'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index].startsWith('User:');
                final text = _messages[index].substring(_messages[index].indexOf(':') + 1).trim();
                
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Ask your coach...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
