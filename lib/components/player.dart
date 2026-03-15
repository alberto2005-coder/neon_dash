import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import '../neon_dash_game.dart';
import 'particle_system.dart';

class Player extends PositionComponent with HasGameReference<NeonDashGame>, CollisionCallbacks {
  static const double playerSize = 40.0;
  static const double gravity = 1500.0;
  static const double jumpForce = -550.0;

  double velocityY = 0;
  int jumpCount = 0;
  static const int maxJumps = 2;
  late double groundY;
  
  late Paint _paint;
  late Paint _corePaint;

  Player() : super(size: Vector2.all(playerSize), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    groundY = game.size.y - 100;
    position = Vector2(100, groundY - playerSize / 2);
    add(RectangleHitbox());
    updateAppearance();
  }

  void updateAppearance() {
    _paint = Paint()
      ..color = game.playerColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);
    
    _corePaint = Paint()..color = Colors.white;
  }

  void jump() {
    if (jumpCount < maxJumps) {
      velocityY = jumpForce;
      jumpCount++;
      
      FlameAudio.play('sfx_jump.mp3', volume: 0.6);
      
      // Add jump particles
      game.add(NeonParticles(
        position: position.clone(),
        color: game.playerColor,
        count: 8,
      ));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y >= groundY - playerSize / 2) {
      position.y = groundY - playerSize / 2;
      velocityY = 0;
      jumpCount = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    
    switch (game.playerShape) {
      case GameShape.square:
        canvas.drawRect(rect, _paint);
        canvas.drawRect(rect.deflate(2), _corePaint);
        break;
      case GameShape.circle:
        canvas.drawCircle(rect.center, size.x / 2, _paint);
        canvas.drawCircle(rect.center, (size.x / 2) - 2, _corePaint);
        break;
      case GameShape.triangle:
        final path = Path()
          ..moveTo(size.x / 2, 0)
          ..lineTo(size.x, size.y)
          ..lineTo(0, size.y)
          ..close();
        canvas.drawPath(path, _paint);
        canvas.drawPath(path, _corePaint..style = PaintingStyle.stroke..strokeWidth = 2);
        _corePaint.style = PaintingStyle.fill; // Reset for next frame
        break;
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    // Collision burst
    game.add(NeonParticles(
      position: position.clone(),
      color: Colors.redAccent,
      count: 20,
    ));
    
    game.gameOver();
  }
}
