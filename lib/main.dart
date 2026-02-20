import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceshooter/constants.dart';
import 'package:spaceshooter/spaceshooter.dart';

void main() {
  runApp(SpaceShooterGame());
}

class SpaceShooterGame extends StatefulWidget {
  const SpaceShooterGame({super.key});

  @override
  State<SpaceShooterGame> createState() => _SpaceShooterGameState();
}

class _SpaceShooterGameState extends State<SpaceShooterGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Shooter',
      home: Scaffold(
        body: GameWidget<SpaceShooter>(
          game: SpaceShooter(),
          overlayBuilderMap: {
            'GameOverMenu': (context, game) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Color.fromARGB(230, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'GAME OVER',
                        style: GoogleFonts.stalinistOne(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Score: ${game.score.toString()}',
                        style: GoogleFonts.stalinistOne(
                          letterSpacing: 3,
                          color: Colors.greenAccent,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          game.restart();
                        },
                        child: Text(
                          'RESTART',
                          style: GoogleFonts.stalinistOne(
                            color: Colors.cyan,
                            letterSpacing: 5,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'ENEMY SPEED',
                        style: GoogleFonts.stalinistOne(
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      SliderWidget(),
                    ],
                  ),
                ),
              );
            },
            'GameStartMenu': (context, game) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Color.fromARGB(230, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SPACE SHOOTER',
                        style: GoogleFonts.stalinistOne(
                          color: Colors.cyanAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'BY AT117',
                        style: GoogleFonts.stalinistOne(
                          letterSpacing: 3,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          game.resumeEngine();
                          game.overlays.remove('GameStartMenu');
                        },
                        child: Text(
                          'PLAY',
                          style: GoogleFonts.stalinistOne(
                            color: Colors.greenAccent,
                            letterSpacing: 5,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'ENEMY SPEED',
                        style: GoogleFonts.stalinistOne(
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      SliderWidget(),
                    ],
                  ),
                ),
              );
            },
          },
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double currentEnemySpeed = GameConfig.enemySpeed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Slider(
        value: currentEnemySpeed,
        min: 120,
        max: 300,
        divisions: 10,
        activeColor: Colors.white,
        onChanged: (value) {
          setState(() {
            currentEnemySpeed = value;
            GameConfig.enemySpeed = value;
          });
        },
      ),
    );
  }
}
