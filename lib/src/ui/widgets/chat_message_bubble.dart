import 'package:flutter/material.dart';
import '../../theme/ai_coach_theme.dart';
import '../../models/chat_message.dart';

/// Custom painter to draw an iOS-style chat bubble with the large swoop tail.
class ChatBubblePainter extends CustomPainter {
  final Color bgColor;
  final Color borderColor;
  final bool isUser;

  ChatBubblePainter({
    required this.bgColor,
    required this.borderColor,
    required this.isUser,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    const radius = 12.0;

    if (isUser) {
      // User bubble (Tail on the right)
      path.moveTo(radius, 0);
      path.lineTo(size.width - 3.5 - radius, 0);
      path.arcToPoint(Offset(size.width - 3.5, radius), radius: const Radius.circular(radius));
      path.lineTo(size.width - 3.5, size.height - 20);
      
      // Right tail swoop (mirrored SVG path)
      path.cubicTo(
        size.width - 3.6, size.height - 6, 
        size.width - 1.5, size.height - 2, 
        size.width - 0.5, size.height
      );
      path.cubicTo(
        size.width - 0.3, size.height + 0.5, 
        size.width - 0.9, size.height + 1, 
        size.width - 1.7, size.height + 0.9
      );
      path.cubicTo(
        size.width - 5.7, size.height + 0.6, 
        size.width - 15.8, size.height - 0.2, 
        size.width - 19.5, size.height
      );
      
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius), radius: const Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(const Offset(radius, 0), radius: const Radius.circular(radius));
    } else {
      // Coach bubble (Tail on the left)
      path.moveTo(size.width - radius, 0);
      path.lineTo(3.5 + radius, 0);
      path.arcToPoint(Offset(3.5, radius), radius: const Radius.circular(radius), clockwise: false);
      path.lineTo(3.5, size.height - 20);
      
      // Left tail swoop (direct SVG path logic)
      path.cubicTo(
        3.6, size.height - 6, 
        1.5, size.height - 2, 
        0.5, size.height
      );
      path.cubicTo(
        0.3, size.height + 0.5, 
        0.9, size.height + 1, 
        1.7, size.height + 0.9
      );
      path.cubicTo(
        5.7, size.height + 0.6, 
        15.8, size.height - 0.2, 
        19.5, size.height
      );
      
      path.lineTo(size.width - radius, size.height);
      path.arcToPoint(Offset(size.width, size.height - radius), radius: const Radius.circular(radius), clockwise: false);
      path.lineTo(size.width, radius);
      path.arcToPoint(Offset(size.width - radius, 0), radius: const Radius.circular(radius), clockwise: false);
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// A widget representing a single chat bubble in the conversation.
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final AiCoachTheme theme;

  const ChatMessageBubble({
    Key? key,
    required this.message,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.0,
        left: isUser ? 48.0 : 8.0,
        right: isUser ? 8.0 : 48.0,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: CustomPaint(
              painter: ChatBubblePainter(
                bgColor: isUser ? theme.cardBackgroundColor : theme.primaryColor.withOpacity(0.08),
                borderColor: isUser ? theme.cardBorderColor : theme.primaryColor,
                isUser: isUser,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: isUser ? 16.0 : 20.0, // Reduced from 28.0
                  right: isUser ? 20.0 : 16.0, // Reduced from 28.0
                  top: 14.0,
                  bottom: 14.0,
                ),
                child: Text(
                  message.text,
                  style: theme.bodyStyle.copyWith(
                    color: theme.bodyStyle.color,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
