import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../neon_dash_game.dart';

enum ObstacleType { standard, flying, stacked }

class Obstacle extends PositionComponent with HasGameReference<NeonDashGame>, CollisionCallbacks {
  final ObstacleType type;
  static const double baseWidth = 40;
  static const double baseHeight = 40;
  late final Path _path;

  Obstacle({required Vector2 position, this.type = ObstacleType.standard}) 
      : super(position: position, size: Vector2(baseWidth, baseHeight));

  @override
  Future<void> onLoad() async {
    if (type == ObstacleType.stacked) {
      size.y = baseHeight * 1.8;
    }

    _path = _createPath();
    
    add(PolygonHitbox.relative(
      [
        Vector2(0, -1), // Top
        Vector2(1, 1),  // Bottom Right
        Vector2(-1, 1), // Bottom Left
      ],
      parentSize: size,
    ));
  }

  Path _createPath() {
    return Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..lineTo(0, size.y)
      ..close();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= game.currentSpeed * dt;

    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = type == ObstacleType.flying ? Colors.orangeAccent : Colors.redAccent
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    
    canvas.drawPath(_path, paint);
    
    final corePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(_path, corePaint);
  }
}
