import 'dart:math';

import 'package:flutter/material.dart';
import 'my_constants.dart';

class MyPainter extends CustomPainter {
  Paint painter;
  final PageController pageController;

  MyPainter({@required this.pageController}) : super(repaint: pageController) {
    painter = Paint()
      ..color = white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (pageController != null && pageController.position != null) {
      final radius = 20.0;
      final dy = 25.0;
      final dxCurrent = 25.0;
      final dxTarget = 125.0;
      final position = pageController.position;
      final extent = (position.maxScrollExtent -
          position.minScrollExtent +
          position.viewportDimension);
      final offset = position.extentBefore / extent;
      bool toRight = dxCurrent < dxTarget;
      Offset entry = Offset(toRight ? dxCurrent : dxTarget, dy);
      Offset target = Offset(toRight ? dxTarget : dxCurrent, dy);
      Path path = Path()
        ..addArc(
            Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi)
        ..addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius))
        ..addArc(
            Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);
      canvas.translate(size.width * offset, 0.0);
      canvas.drawShadow(path, base, 7.5, true);
      canvas.drawPath(path, painter);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}
