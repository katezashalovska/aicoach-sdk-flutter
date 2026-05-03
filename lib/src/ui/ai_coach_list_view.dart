import 'package:flutter/material.dart';
import '../theme/ai_coach_theme.dart';
import '../models/coach.dart';
import '../data/mock_ai_coach_data.dart';
import 'widgets/coach_card.dart';
import 'ai_coach_details_view.dart';
import 'widgets/ai_coach_app_bar.dart';

class AiCoachListView extends StatelessWidget {
  final AiCoachTheme theme;
  final void Function(Coach coach) onCoachChosen;
  final void Function(Coach coach)? onCoachDetails;

  const AiCoachListView({
    Key? key,
    this.theme = const AiCoachTheme(),
    required this.onCoachChosen,
    this.onCoachDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coaches = MockAiCoachData.coaches;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: 'Chat with coach',
        theme: theme,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          Text(
            'Choose the coach',
            style: theme.headingStyle,
          ),
          const SizedBox(height: 12),
          Text(
            'Learn about the coaches\' skills and choose the one best suited to help you with your question',
            style: theme.bodyStyle,
          ),
          const SizedBox(height: 24),
          ...coaches.map((coach) => CoachCard(
                coach: coach,
                theme: theme,
                onDetailsPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AiCoachDetailsView(
                        coach: coach,
                        theme: theme,
                        onChoosePressed: (selectedCoach) =>
                            onCoachChosen(selectedCoach),
                      ),
                    ),
                  );
                  onCoachDetails?.call(coach);
                },
                onChoosePressed: () => onCoachChosen(coach),
              )),
        ],
      ),
    );
  }
}
