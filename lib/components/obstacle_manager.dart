import 'dart:math';
import 'package:flame/components.dart';
import '../neon_dash_game.dart';
import 'obstacle.dart';

class ObstacleManager extends Component with HasGameReference<NeonDashGame> {
  final Random _random = Random();
  double _timer = 0;
  double _spawnInterval = 2.0;

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;

    if (_timer >= _spawnInterval) {
      _spawnPattern();
      _timer = 0;
      // Faster spawning as game progresses
      _spawnInterval = max(0.8, (1.5 + _random.nextDouble() * 1.5) - (game.currentSpeed - 200) / 500);
    }
  }

  void _spawnPattern() {
    final patternType = _random.nextInt(10);
    
    if (patternType < 5) {
      _spawn(ObstacleType.standard);
    } else if (patternType < 7) {
      _spawn(ObstacleType.flying);
    } else if (patternType < 9) {
      _spawn(ObstacleType.stacked);
    } else {
      // Duo pattern
      _spawn(ObstacleType.standard);
      Future.delayed(const Duration(milliseconds: 400), () => _spawn(ObstacleType.standard));
    }
  }

  void _spawn(ObstacleType type) {
    double yPos;
    final groundY = game.size.y - 100;
    
    switch (type) {
      case ObstacleType.standard:
        yPos = groundY - Obstacle.baseHeight;
        break;
      case ObstacleType.flying:
        yPos = groundY - Obstacle.baseHeight - 120; // High enough to jump under or over
        break;
      case ObstacleType.stacked:
        yPos = groundY - (Obstacle.baseHeight * 1.8);
        break;
    }

    final obstacle = Obstacle(
      position: Vector2(game.size.x, yPos),
      type: type,
    );
    game.add(obstacle);
  }

  void reset() {
    _timer = 0;
    _spawnInterval = 2.0;
  }
}
