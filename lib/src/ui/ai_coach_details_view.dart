import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/ai_coach_theme.dart';
import '../models/coach.dart';
import 'widgets/coach_tag.dart';
import 'widgets/ai_coach_app_bar.dart';

class AiCoachDetailsView extends StatefulWidget {
  final Coach coach;
  final AiCoachTheme theme;
  final void Function(Coach coach) onChoosePressed;

  const AiCoachDetailsView({
    Key? key,
    required this.coach,
    this.theme = const AiCoachTheme(),
    required this.onChoosePressed,
  }) : super(key: key);

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
            // Coach Name
            Text(
              widget.coach.name,
              style: widget.theme.headingStyle,
            ),
            const SizedBox(height: 16),

            // Image
            ClipRRect(
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
                  child: Icon(Icons.person,
                      size: 80, color: widget.theme.secondaryTextColor),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tags (Solid mode)
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                CoachTag(
                  theme: widget.theme,
                  iconPath: 'assets/icons/ic_like.svg',
                  label: widget.coach.rating.toString(),
                  isGlass: false,
                ),
                CoachTag(
                  theme: widget.theme,
                  iconPath: 'assets/icons/ic_profile.svg',
                  label: widget.coach.userCount,
                  isGlass: false,
                ),
                ...widget.coach.tags.map((tag) => CoachTag(
                      theme: widget.theme,
                      label: tag,
                      isGlass: false,
                    )),
              ],
            ),
            const SizedBox(height: 16),

            // Tab Buttons
            Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'About',
                    isActive: _isAboutTab,
                    theme: widget.theme,
                    onTap: () => setState(() => _isAboutTab = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TabButton(
                    label: 'Reviews',
                    isActive: !_isAboutTab,
                    theme: widget.theme,
                    onTap: () => setState(() => _isAboutTab = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content based on tab
            if (_isAboutTab) _buildAboutTab() else _buildReviewsTab(),

            const SizedBox(height: 16),

            // Bottom Choose Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => widget.onChoosePressed(widget.coach),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.theme.primaryColor,
                  foregroundColor: widget.theme.onPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.theme.buttonRadius),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Choose',
                  style: widget.theme.buttonStyle,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: widget.theme.headingStyle,
        ),
        const SizedBox(height: 16),
        ...widget.coach.achievements.map((achievement) => Padding(
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
                      colorFilter: ColorFilter.mode(
                        widget.theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                      package: 'ai_coach_jack',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      achievement,
                      style: widget.theme.bodyStyle,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.coach.reviews.map((review) => Padding(
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
                    widget.theme.primaryColor,
                    BlendMode.srcIn,
                  ),
                  package: 'ai_coach_jack',
                ),
                const SizedBox(width: 8),
                Text(
                  review.rating.toString(),
                  style: widget.theme.bodyStyle.copyWith(fontSize: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  review.userName,
                  style: widget.theme.subTitleStyle,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.title,
              style: widget.theme.headingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              review.content,
              style: widget.theme.bodyStyle.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final AiCoachTheme theme;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(theme.buttonRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? theme.primaryColor.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(theme.buttonRadius),
            border: Border.all(
              color: isActive ? theme.primaryColor : theme.cardBorderColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.secondaryButtonStyle,
            ),
          ),
        ),
      ),
    );
  }
}
