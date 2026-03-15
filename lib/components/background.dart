import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../neon_dash_game.dart';

class Background extends Component with HasGameReference<NeonDashGame> {
  @override
  void render(Canvas canvas) {
    canvas.drawColor(const Color(0xFF1A1A1A), BlendMode.srcOver);
    
    // Dynamic color based on speed
    final hue = (game.currentSpeed - 200) % 360;
    final accentColor = HSVColor.fromAHSV(1.0, hue, 0.8, 1.0).toColor();

    // Draw floor
    final paint = Paint()
      ..color = accentColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(0, game.size.y - 100, game.size.x, 100),
      paint,
    );

    final linePaint = Paint()
      ..color = accentColor.withValues(alpha: 0.5)
      ..strokeWidth = 2;
    
    canvas.drawLine(
      Offset(0, game.size.y - 100),
      Offset(game.size.x, game.size.y - 100),
      linePaint,
    );
    
    // Grid-like effect
    final gridPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.05)
      ..strokeWidth = 1;
    for (var i = 1; i < 5; i++) {
      final y = game.size.y - 100 + (i * 20);
      canvas.drawLine(Offset(0, y), Offset(game.size.x, y), gridPaint);
    }
  }
}
