import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTimerPainter extends CustomPainter {
  
  final Animation<double> animation;
  final Color backGroundColor, color;
  
  CustomTimerPainter({
    this.animation,
    this.backGroundColor,
    this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = backGroundColor
    ..strokeWidth = 10.0
    ..strokeCap = StrokeCap.butt
    ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
  return animation.value != old.animation.value ||
      color != old.color;
  }
}