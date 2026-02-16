import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/components/enemy.dart';
import 'package:spaceshooter/components/planet.dart';
import 'package:spaceshooter/components/turret.dart';

class SpaceShooter extends FlameGame with HasCollisionDetection, PanDetector {
  late Turret turret;

  @override
  Color backgroundColor() {
    return Color(0xFF000814);
  }

  @override
  FutureOr<void> onLoad() async {
    final center = size / 2;
    add(Planet()..position = center);
    turret = Turret()..position = center;
    add(turret);

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

  @override
  void onPanUpdate(DragUpdateInfo info) {
    turret.lookAt(info.eventPosition.widget);
  }

  @override
  void onPanDown(DragDownInfo info) {
    turret.shoot();
  }
}
