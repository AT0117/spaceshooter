import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/constants.dart';

class Turret extends PositionComponent with HasGameReference {
  late final RectangleComponent barrel;

  Turret() : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    barrel = RectangleComponent(
      size: Vector2(GameConfig.turretHeight, GameConfig.turretHeight),
      position: Vector2(0, -GameConfig.planetRadius),
      paint: Paint()..color = Colors.white,
    );
    add(barrel);
  }

  void shoot() {
    final bullet = Bullet(
      position: barrel.absolutePosition,
      angleAtFire: angle,
    );
    game.add(bullet);
  }
}
