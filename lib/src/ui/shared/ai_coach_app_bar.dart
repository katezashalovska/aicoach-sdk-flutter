import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/ai_coach_theme.dart';

/// A reusable AppBar for the AI Coach SDK
class AiCoachAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the center of the AppBar.
  final String title;

  /// The theme configuration for styling.
  final AiCoachTheme theme;

  /// Optional callback for the back button.
  final VoidCallback? onBackPress;

  const AiCoachAppBar({
    Key? key,
    required this.title,
    required this.theme,
    this.onBackPress,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AppBar(
        backgroundColor: theme.backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: SvgPicture.asset(
                'assets/icons/ic_back.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  theme.titleStyle.color!,
                  BlendMode.srcIn,
                ),
                package: 'ai_coach_jack',
              ),
              onPressed: onBackPress ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  },
            ),
          ),
        ),
        title: Text(
          title,
          style: theme.titleStyle,
        ),
      ),
    );
  }
}
