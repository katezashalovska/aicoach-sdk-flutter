import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/coach.dart';

/// A widget representing a single user review for a coach.
class CoachReviewItem extends StatelessWidget {
  final CoachReview review;
  final AiCoachTheme theme;

  const CoachReviewItem({
    super.key,
    required this.review,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_star.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
                package: 'aicoach_sdk_flutter',
              ),
              const SizedBox(width: 8),
              Text(
                review.rating.toString(),
                style: theme.bodyStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(width: 12),
              Text(
                review.userName,
                style: theme.subTitleStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.title,
            style: theme.headingStyle,
          ),
          const SizedBox(height: 8),
          Text(
            review.content,
            style: theme.bodyStyle.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
