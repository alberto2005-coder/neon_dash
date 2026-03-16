import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';
import 'components/background.dart';
import 'components/player.dart';
import 'components/obstacle_manager.dart';
import 'components/obstacle.dart';

enum GameShape { square, circle, triangle }

class NeonDashGame extends FlameGame with TapCallbacks, KeyboardEvents, HasCollisionDetection {
  late Player player;
  late ObstacleManager obstacleManager;
  
  double currentSpeed = 200.0;
  double score = 0;
  int highScore = 0;
  Color playerColor = Colors.cyanAccent;
  GameShape playerShape = GameShape.square;
  String language = 'es'; // 'es' or 'en'

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'menu_title': 'NEON DASH',
      'high_score': 'Récord: ',
      'customize': 'PERSONALIZA TU NEÓN',
      'start': 'ARRANCAR MOTOR',
      'paused': 'PAUSADO',
      'resume': 'CONTINUAR',
      'restart': 'REINICIAR',
      'main_menu': 'MENÚ PRINCIPAL',
      'game_over': 'FALLO DE MOTOR',
      'final_score': 'PUNTUACIÓN FINAL: ',
      'record': 'RÉCORD: ',
      'engage_restart': 'REINTENTAR',
      'back_menu': 'VOLVER AL MENÚ',
      'quit': 'SALIR DEL JUEGO',
    },
    'en': {
      'menu_title': 'NEON DASH',
      'high_score': 'High Score: ',
      'customize': 'CUSTOMIZE YOUR NEON',
      'start': 'START ENGINE',
      'paused': 'PAUSED',
      'resume': 'RESUME',
      'restart': 'RESTART',
      'main_menu': 'MAIN MENU',
      'game_over': 'ENGINE FAILURE',
      'final_score': 'FINAL SCORE: ',
      'record': 'RECORD: ',
      'engage_restart': 'ENGAGE RESTART',
      'back_menu': 'BACK TO MENU',
      'quit': 'QUIT GAME',
    },
  };

  String t(String key) => _translations[language]?[key] ?? key;

  @override
  Future<void> onLoad() async {
    await loadSettings();
    
    // Preload audio
    await FlameAudio.audioCache.loadAll([
      'sfx_jump.mp3',
      'sfx_explosion.mp3',
      'music_menu.mp3',
      'music_game.mp3',
    ]);
    
    add(Background());
    add(player = Player());
    add(obstacleManager = ObstacleManager());
    
    pauseEngine();
    overlays.add('MainMenu');
    FlameAudio.bgm.play('music_menu.mp3', volume: 0.4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    score += dt * (currentSpeed / 100);
    _speedTimer += dt;
    
    if (_speedTimer >= 5) {
      currentSpeed += 20; // Doubled from 10 for more noticeable progression
      _speedTimer = 0;
    }
  }

  double _speedTimer = 0;

  @override
  void onTapDown(TapDownEvent event) {
    if (overlays.isActive('MainMenu') || overlays.isActive('GameOver') || overlays.isActive('PauseMenu')) return;
    player.jump();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.space) || 
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        if (!overlays.isActive('MainMenu') && !overlays.isActive('GameOver') && !overlays.isActive('PauseMenu')) {
          player.jump();
        }
        return KeyEventResult.handled;
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void startGame() {
    overlays.remove('MainMenu');
    reset();
  }

  void pauseGame() {
    pauseEngine();
    overlays.add('PauseMenu');
  }

  void resumeGame() {
    overlays.remove('PauseMenu');
    resumeEngine();
  }

  void gameOver() {
    pauseEngine();
    try {
      FlameAudio.bgm.stop();
      FlameAudio.play('sfx_explosion.mp3', volume: 0.7);
    } catch (_) {}
    
    // Avoid haptics on desktop to prevent potential threading crashes in some drivers
    if (!kIsWeb && Platform.isAndroid || Platform.isIOS) {
      HapticFeedback.heavyImpact();
    }
    
    if (score.toInt() > highScore) {
      highScore = score.toInt();
      saveSettings();
    }
    overlays.add('GameOver');
  }

  void reset() {
    score = 0;
    currentSpeed = 200;
    _speedTimer = 0;
    
    player.position = Vector2(100, size.y - 100 - Player.playerSize / 2);
    player.velocityY = 0;
    player.jumpCount = 0;
    player.updateAppearance();
    
    obstacleManager.reset();
    children.whereType<Obstacle>().forEach((o) => o.removeFromParent());
    
    try {
      FlameAudio.bgm.stop();
      FlameAudio.bgm.play('music_game.mp3', volume: 0.5);
    } catch (_) {}
    
    overlays.remove('GameOver');
    overlays.remove('PauseMenu');
    resumeEngine();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    highScore = prefs.getInt('highScore') ?? 0;
    
    final colorVal = prefs.getInt('playerColor') ?? Colors.cyanAccent.value;
    playerColor = Color(colorVal);
    
    final shapeIndex = prefs.getInt('playerShape') ?? 0;
    playerShape = GameShape.values[shapeIndex];
    language = prefs.getString('language') ?? 'es';
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highScore', highScore);
    await prefs.setInt('playerColor', playerColor.value);
    await prefs.setInt('playerShape', playerShape.index);
    await prefs.setString('language', language);
  }
  
  void setPlayerColor(Color color) {
    playerColor = color;
    player.updateAppearance();
    saveSettings();
  }
  
  void setPlayerShape(GameShape shape) {
    playerShape = shape;
    player.updateAppearance();
    saveSettings();
  }

  void toggleLanguage() {
    language = language == 'es' ? 'en' : 'es';
    saveSettings();
  }
}
