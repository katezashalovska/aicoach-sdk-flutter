import 'package:flutter/material.dart';
import '../../../theme/ai_coach_theme.dart';

/// A stylized tab button used for switching between views (e.g. About/Reviews).
class TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final AiCoachTheme theme;
  final VoidCallback onTap;

  const TabButton({
    super.key,
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
