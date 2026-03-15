import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'neon_dash_game.dart';

void main() {
  runApp(const NeonDashApp());
}

class NeonDashApp extends StatelessWidget {
  const NeonDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neon Dash',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        fontFamily: 'Courier', // Cyberpunk/Retro feel
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final NeonDashGame game;

  @override
  void initState() {
    super.initState();
    game = NeonDashGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'MainMenu': (context, NeonDashGame game) => MainMenuOverlay(game: game),
          'PauseMenu': (context, NeonDashGame game) => PauseMenuOverlay(game: game),
          'GameOver': (context, NeonDashGame game) => GameOverOverlay(game: game),
          'HUD': (context, NeonDashGame game) => HUDOverlay(game: game),
        },
        initialActiveOverlays: const ['HUD'], // MainMenu is added by game.onLoad
      ),
    );
  }
}

class MainMenuOverlay extends StatelessWidget {
  final NeonDashGame game;
  const MainMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          return Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: game.playerColor, width: 2),
            ),
            child: Stack(
              children: [
                // Language Toggle
                Positioned(
                  right: 0,
                  top: 0,
                  child: TextButton(
                    onPressed: () => game.toggleLanguage(),
                    child: Text(
                      game.language.toUpperCase(),
                      style: TextStyle(color: game.playerColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        game.t('menu_title'),
                        style: TextStyle(
                          color: game.playerColor,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 8,
                          shadows: [Shadow(color: game.playerColor, blurRadius: 20)],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${game.t('high_score')}${game.highScore}',
                        style: const TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 30),
                      
                      // Customization Section
                      Text(game.t('customize'), style: const TextStyle(color: Colors.white54, fontSize: 14)),
                      const SizedBox(height: 16),
                      
                      // Color Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _colorButton(Colors.cyanAccent),
                          _colorButton(Colors.purpleAccent),
                          _colorButton(Colors.greenAccent),
                          _colorButton(Colors.orangeAccent),
                          _colorButton(Colors.white),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Shape Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _shapeButton(GameShape.square, Icons.stop),
                          _shapeButton(GameShape.circle, Icons.circle),
                          _shapeButton(GameShape.triangle, Icons.change_history),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: game.playerColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          elevation: 10,
                          shadowColor: game.playerColor,
                        ),
                        onPressed: () => game.startGame(),
                        child: Text(game.t('start')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => game.setPlayerColor(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: game.playerColor == color ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10)],
        ),
      ),
    );
  }

  Widget _shapeButton(GameShape shape, IconData icon) {
    return IconButton(
      onPressed: () => game.setPlayerShape(shape),
      icon: Icon(icon, 
        color: game.playerShape == shape ? game.playerColor : Colors.white24,
        size: 32,
      ),
    );
  }
}

class PauseMenuOverlay extends StatelessWidget {
  final NeonDashGame game;
  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  game.t('paused'),
                  style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => game.toggleLanguage(),
                  child: Text(
                    game.language.toUpperCase(),
                    style: TextStyle(color: game.playerColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _menuButton(
              label: game.t('resume'), 
              color: Colors.greenAccent, 
              onPressed: () => game.resumeGame()
            ),
            const SizedBox(height: 16),
            _menuButton(
              label: game.t('restart'), 
              color: Colors.orangeAccent, 
              onPressed: () => game.reset()
            ),
            const SizedBox(height: 16),
            _menuButton(
              label: game.t('main_menu'), 
              color: Colors.redAccent, 
              onPressed: () {
                game.overlays.remove('PauseMenu');
                game.overlays.add('MainMenu');
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({required String label, required Color color, required VoidCallback onPressed}) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: color,
          side: BorderSide(color: color, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class GameOverOverlay extends StatelessWidget {
  final NeonDashGame game;
  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.redAccent, width: 2),
          boxShadow: const [BoxShadow(color: Colors.redAccent, blurRadius: 20)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              game.t('game_over'),
              style: const TextStyle(color: Colors.redAccent, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${game.t('final_score')}${game.score.toInt()}',
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            Text(
              '${game.t('record')}${game.highScore}',
              style: const TextStyle(color: Colors.cyanAccent, fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              onPressed: () => game.reset(),
              child: Text(game.t('engage_restart'), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                game.overlays.remove('GameOver');
                game.overlays.add('MainMenu');
              },
              child: Text(game.t('back_menu'), style: const TextStyle(color: Colors.white54)),
            ),
          ],
        ),
      ),
    );
  }
}

class HUDOverlay extends StatelessWidget {
  final NeonDashGame game;
  const HUDOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Score
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 50)),
            builder: (context, snapshot) {
              return Center(
                child: Text(
                  '${game.score.toInt()}',
                  style: TextStyle(
                    color: game.playerColor,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: game.playerColor, blurRadius: 10)],
                  ),
                ),
              );
            }
          ),
        ),
        // Pause Button
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.pause, color: Colors.white70, size: 36),
            onPressed: () => game.pauseGame(),
          ),
        ),
      ],
    );
  }
}
