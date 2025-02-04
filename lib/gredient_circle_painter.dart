import 'package:flutter/cupertino.dart';

class GradientCirclePainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;

  GradientCirclePainter({
    required this.gradient,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
      )
      ..strokeCap = StrokeCap.round; // Ensures smooth circular edges

    final double radius = (size.width / 2) - (strokeWidth / 2);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}