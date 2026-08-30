import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final int value;

  const IconBadge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseFontSize = textTheme.bodyMedium?.fontSize ?? 14;
    final displayText = value > 99 ? '99+' : '$value';

    final textStyle = TextStyle(
      color: const Color(0xFFF7F1FF),
      fontSize: baseFontSize,
      fontWeight: FontWeight.w700,
      height: 1,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: displayText, style: textStyle),
      textDirection: Directionality.of(context),
    )..layout();

    final horizontalPadding = baseFontSize * 0.2;
    final verticalPadding = baseFontSize * 0.2;
    final badgeWidth = textPainter.width + horizontalPadding * 2;
    final badgeHeight = textPainter.height + verticalPadding * 2;
    final badgeSize = (badgeWidth > badgeHeight ? badgeWidth : badgeHeight)
        .clamp(baseFontSize * 1.2, double.infinity);

    return Container(
      width: badgeSize,
      height: badgeSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFE71945),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF50071A).withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(displayText, textAlign: TextAlign.center, style: textStyle),
    );
  }
}
