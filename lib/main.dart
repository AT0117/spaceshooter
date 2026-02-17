import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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
                  color: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'GAME OVER',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          game.restart();
                        },
                        child: Text('RESTART'),
                      ),
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
