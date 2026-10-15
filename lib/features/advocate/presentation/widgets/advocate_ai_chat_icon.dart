import 'package:flutter/material.dart';

/// Custom AI Chat Sparkle Icon matching the reference design in the search bar
class AdvocateAiChatIcon extends StatelessWidget {
  final double size;
  final Color color;

  const AdvocateAiChatIcon({
    super.key,
    this.size = 28,
    this.color = const Color(0xFF0F172A),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _AdvocateAiChatIconPainter(color: color),
    );
  }
}

class _AdvocateAiChatIconPainter extends CustomPainter {
  final Color color;

  _AdvocateAiChatIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Speech bubble path (leaving space on top-right for sparkle)
    final bubblePath = Path();
    bubblePath.moveTo(w * 0.58, h * 0.16);
    bubblePath.lineTo(w * 0.32, h * 0.16);
    bubblePath.quadraticBezierTo(w * 0.12, h * 0.16, w * 0.12, h * 0.36);
    bubblePath.lineTo(w * 0.12, h * 0.62);
    bubblePath.quadraticBezierTo(w * 0.12, h * 0.82, w * 0.32, h * 0.82);
    bubblePath.lineTo(w * 0.32, h * 0.94); // tail
    bubblePath.lineTo(w * 0.46, h * 0.82);
    bubblePath.lineTo(w * 0.68, h * 0.82);
    bubblePath.quadraticBezierTo(w * 0.88, h * 0.82, w * 0.88, h * 0.62);
    bubblePath.lineTo(w * 0.88, h * 0.38);

    canvas.drawPath(bubblePath, strokePaint);

    // Two horizontal lines inside the speech bubble
    canvas.drawLine(
      Offset(w * 0.30, h * 0.44),
      Offset(w * 0.62, h * 0.44),
      strokePaint,
    );
    canvas.drawLine(
      Offset(w * 0.30, h * 0.58),
      Offset(w * 0.52, h * 0.58),
      strokePaint,
    );

    // 4-point diamond sparkle at top right: center at (0.84 * w, 0.20 * h)
    final sparkleCenter = Offset(w * 0.84, h * 0.20);
    final spR = w * 0.15; // sparkle radius
    final sparklePath = Path();
    sparklePath.moveTo(sparkleCenter.dx, sparkleCenter.dy - spR);
    sparklePath.quadraticBezierTo(
      sparkleCenter.dx,
      sparkleCenter.dy,
      sparkleCenter.dx + spR,
      sparkleCenter.dy,
    );
    sparklePath.quadraticBezierTo(
      sparkleCenter.dx,
      sparkleCenter.dy,
      sparkleCenter.dx,
      sparkleCenter.dy + spR,
    );
    sparklePath.quadraticBezierTo(
      sparkleCenter.dx,
      sparkleCenter.dy,
      sparkleCenter.dx - spR,
      sparkleCenter.dy,
    );
    sparklePath.quadraticBezierTo(
      sparkleCenter.dx,
      sparkleCenter.dy,
      sparkleCenter.dx,
      sparkleCenter.dy - spR,
    );
    sparklePath.close();

    canvas.drawPath(sparklePath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
