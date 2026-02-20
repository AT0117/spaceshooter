import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceshooter/components/background.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/components/enemy.dart';
import 'package:spaceshooter/components/planet.dart';
import 'package:spaceshooter/components/turret.dart';

class SpaceShooter extends FlameGame with HasCollisionDetection, PanDetector {
  late Turret turret;
  int score = 0;
  late TextComponent scoreText = TextComponent(
    position: Vector2(20, 40),
    textRenderer: TextPaint(
      style: GoogleFonts.stalinistOne(color: Colors.white),
    ),
    text: '',
  );

  @override
  FutureOr<void> onLoad() async {
    await add(SpaceBackground());
    pauseEngine();
    overlays.add('GameStartMenu');
    final center = size / 2;
    add(Planet()..position = center);
    turret = Turret()..position = center;
    add(turret);
    add(scoreText);
    add(
      SpawnComponent(
        factory: (index) {
          final random = Random();
          double x, y;
          if (random.nextBool()) {
            x = random.nextBool() ? 0 : size.x;
            y = random.nextDouble() * size.y;
          } else {
            x = random.nextDouble() * size.x;
            y = random.nextBool() ? 0 : size.y;
          }
          return Enemy(position: Vector2(x, y));
        },
        period: 1.5,
        selfPositioning: true,
      ),
    );
  }

  void incrementScore() {
    score += 1;
    scoreText.text = 'Score: $score';
  }

  void restart() {
    score = 0;
    scoreText.text = 'Score: 0';
    children.whereType<Enemy>().forEach((e) => e.removeFromParent());
    children.whereType<Bullet>().forEach((b) => b.removeFromParent());
    overlays.remove('GameOverMenu');
    resumeEngine();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    turret.lookAt(info.eventPosition.widget);
  }

  @override
  void onPanDown(DragDownInfo info) {
    turret.shoot();
  }
}
