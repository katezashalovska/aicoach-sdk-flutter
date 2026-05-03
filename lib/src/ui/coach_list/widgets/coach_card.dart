import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/coach.dart';
import 'coach_tag.dart';

class CoachCard extends StatelessWidget {
  final Coach coach;
  final AiCoachTheme theme;
  final VoidCallback onDetailsPressed;
  final VoidCallback onChoosePressed;

  const CoachCard({
    Key? key,
    required this.coach,
    required this.theme,
    required this.onDetailsPressed,
    required this.onChoosePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.cardBorderColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coach Name
          Text(
            coach.name,
            style: theme.subTitleStyle,
          ),
          const SizedBox(height: 16),
          
          // Image with Tags Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  coach.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    width: double.infinity,
                    color: theme.placeholderColor,
                    child: Icon(Icons.person, size: 64, color: theme.secondaryTextColor),
                  ),
                ),
              ),
              
              // Tags
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    CoachTag(
                      theme: theme,
                      iconPath: 'assets/icons/ic_like.svg',
                      label: coach.rating.toString(),
                      isGlass: true,
                    ),
                    CoachTag(
                      theme: theme,
                      iconPath: 'assets/icons/ic_profile.svg',
                      label: coach.userCount,
                      isGlass: true,
                    ),
                    ...coach.tags.map((tag) => CoachTag(
                          theme: theme,
                          label: tag,
                          isGlass: true,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDetailsPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(theme.buttonRadius),
                    ),
                  ),
                  child: Text(
                    'See details',
                    style: theme.secondaryButtonStyle,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onChoosePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.onAccentColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(theme.buttonRadius),
                    ),
                  ),
                  child: Text(
                    'Choose',
                    style: theme.buttonStyle.copyWith(color: theme.onAccentColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
