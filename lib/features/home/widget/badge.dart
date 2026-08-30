import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final int value;
  final double size;

  const IconBadge({super.key, required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    final fontSize = size * 0.6;

    return Container(
      width: size,
      height: size,
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
      child: Text(
        '$value',
        style: TextStyle(
          color: const Color(0xFFF7F1FF),
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
