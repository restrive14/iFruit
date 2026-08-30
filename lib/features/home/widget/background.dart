import 'package:flutter/material.dart';

class BlueHomePainter extends CustomPainter {
  const BlueHomePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = const Color(0xFF0649EE);
    canvas.drawRect(Offset.zero & size, base);

    final dark = Paint()
      ..color = const Color(0xFF043BD0).withValues(alpha: 0.5);
    final light = Paint()
      ..color = const Color(0xFF0D6CFF).withValues(alpha: 0.44);
    final mid = Paint()
      ..color = const Color(0xFF0757E7).withValues(alpha: 0.55);

    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.12)
        ..lineTo(size.width * 0.72, size.height * 0.05)
        ..lineTo(size.width * 0.58, size.height * 0.26)
        ..lineTo(0, size.height * 0.31)
        ..close(),
      light,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.32, size.height * 0.10)
        ..lineTo(size.width, size.height * 0.13)
        ..lineTo(size.width, size.height * 0.48)
        ..lineTo(size.width * 0.46, size.height * 0.38)
        ..close(),
      mid,
    );

    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.43)
        ..lineTo(size.width * 0.42, size.height * 0.36)
        ..lineTo(size.width * 0.56, size.height * 0.67)
        ..lineTo(0, size.height * 0.74)
        ..close(),
      dark,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.18, size.height)
        ..lineTo(size.width, size.height * 0.72)
        ..lineTo(size.width, size.height)
        ..close(),
      light,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
