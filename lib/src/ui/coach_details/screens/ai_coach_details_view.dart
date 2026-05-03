import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/ai_coach_theme.dart';
import '../../../models/coach.dart';
import '../../coach_list/widgets/coach_tag.dart';
import '../../shared/ai_coach_app_bar.dart';
import '../widgets/coach_review_item.dart';
import '../widgets/tab_button.dart';

class AiCoachDetailsView extends StatefulWidget {
  final Coach coach;
  final AiCoachTheme theme;
  final void Function(Coach coach) onChoosePressed;

  const AiCoachDetailsView({
    super.key,
    required this.coach,
    this.theme = const AiCoachTheme(),
    required this.onChoosePressed,
  });

  @override
  State<AiCoachDetailsView> createState() => _AiCoachDetailsViewState();
}

class _AiCoachDetailsViewState extends State<AiCoachDetailsView> {
  bool _isAboutTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AiCoachAppBar(
        title: 'Chat with coach',
        theme: widget.theme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.coach.name, style: widget.theme.headingStyle),
            const SizedBox(height: 16),
            _buildCoachImage(),
            const SizedBox(height: 16),
            _buildTags(),
            const SizedBox(height: 16),
            _buildTabs(),
            const SizedBox(height: 16),
            if (_isAboutTab) _buildAboutTab() else _buildReviewsTab(),
            const SizedBox(height: 16),
            _buildChooseButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.network(
        widget.coach.imageUrl,
        height: 196,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 196,
          width: double.infinity,
          color: widget.theme.placeholderColor,
          child: Icon(Icons.person, size: 80, color: widget.theme.secondaryTextColor),
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        CoachTag(theme: widget.theme, iconPath: 'assets/icons/ic_like.svg', label: widget.coach.rating.toString(), isGlass: false),
        CoachTag(theme: widget.theme, iconPath: 'assets/icons/ic_profile.svg', label: widget.coach.userCount, isGlass: false),
        ...widget.coach.tags.map((tag) => CoachTag(theme: widget.theme, label: tag, isGlass: false)),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(child: TabButton(label: 'About', isActive: _isAboutTab, theme: widget.theme, onTap: () => setState(() => _isAboutTab = true))),
        const SizedBox(width: 12),
        Expanded(child: TabButton(label: 'Reviews', isActive: !_isAboutTab, theme: widget.theme, onTap: () => setState(() => _isAboutTab = false))),
      ],
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Achievements', style: widget.theme.headingStyle),
        const SizedBox(height: 16),
        ...widget.coach.achievements.map((achievement) => _AchievementItem(achievement: achievement, theme: widget.theme)),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.coach.reviews.map((review) => CoachReviewItem(review: review, theme: widget.theme)).toList(),
    );
  }

  Widget _buildChooseButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => widget.onChoosePressed(widget.coach),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.theme.primaryColor,
          foregroundColor: widget.theme.onAccentColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.theme.buttonRadius)),
          elevation: 0,
        ),
        child: Text('Choose', style: widget.theme.buttonStyle),
      ),
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final String achievement;
  final AiCoachTheme theme;

  const _AchievementItem({required this.achievement, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SvgPicture.asset(
              'assets/icons/ic_check.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              package: 'ai_coach_jack',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(achievement, style: theme.bodyStyle)),
        ],
      ),
    );
  }
}
