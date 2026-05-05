import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/ai_coach_theme.dart';

class CoachTag extends StatelessWidget {
  final AiCoachTheme theme;
  final String? iconPath;
  final String label;
  final bool isGlass;

  const CoachTag({
    Key? key,
    required this.theme,
    this.iconPath,
    required this.label,
    this.isGlass = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGlass) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: _buildContainer(),
        ),
      );
    }
    return _buildContainer();
  }

  Widget _buildContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Reduced vertical from 8
      constraints: const BoxConstraints(minWidth: 44),
      decoration: BoxDecoration(
        color: isGlass
            ? const Color(0x66494949)
            : theme.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.primaryColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null) ...[
            SvgPicture.asset(
              iconPath!,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                isGlass ? theme.onAccentColor : theme.primaryColor,
                BlendMode.srcIn,
              ),
              package: 'aicoach_sdk_flutter',
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: isGlass ? theme.onAccentColor : theme.secondaryButtonStyle.color,
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
