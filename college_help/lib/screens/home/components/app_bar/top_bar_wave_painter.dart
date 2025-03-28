import 'package:flutter/material.dart';
import 'dart:math' as math;

class TopBarWavePainter extends CustomPainter {
  final double animation;

  TopBarWavePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle wave patterns
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.07)
          ..style = PaintingStyle.fill;

    const wavePeriod = 3.0;
    const waveAmplitude = 4.0;

    final path = Path();

    // Starting from the bottom
    path.moveTo(0, size.height * 0.8);

    // Drawing the wave
    for (double x = 0; x <= size.width; x++) {
      final y =
          size.height * 0.8 +
          math.sin(
                (x / size.width * wavePeriod * math.pi) +
                    (animation * math.pi * 2),
              ) *
              waveAmplitude;
      path.lineTo(x, y);
    }

    // Completing the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw some decorative particles
    final particlePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final particleX = size.width * ((i * 127) % 100) / 100;
      final particleY = size.height * ((i * 59) % 60) / 100;
      final particleSize = 0.5 + ((i * 13) % 3) / 2;

      canvas.drawCircle(
        Offset(particleX, particleY),
        particleSize,
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TopBarWavePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
