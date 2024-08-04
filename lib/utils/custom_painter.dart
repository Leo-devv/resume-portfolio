import 'package:flutter/material.dart';
import 'dart:math';

class Particle {
  double x, y, vx, vy, ox, oy;
  Particle({required this.x, required this.y, this.vx = 0, this.vy = 0})
      : ox = x,
        oy = y;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePosition;
  final double thickness;
  final double drag;
  final double ease;

  ParticlePainter({
    required this.particles,
    required this.mousePosition,
    this.thickness = 6400, // 80^2
    this.drag = 0.95,
    this.ease = 0.25,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var p in particles) {
      final dx = mousePosition.dx - p.x;
      final dy = mousePosition.dy - p.y;
      final d = dx * dx + dy * dy;

      if (d < thickness) {
        final f = -thickness / d;
        final t = atan2(dy, dx);
        p.vx += f * cos(t);
        p.vy += f * sin(t);
      }

      p.x += (p.vx *= drag) + (p.ox - p.x) * ease;
      p.y += (p.vy *= drag) + (p.oy - p.y) * ease;

      canvas.drawCircle(Offset(p.x, p.y), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
