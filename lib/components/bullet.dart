import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:spaceshooter/constants.dart';

class Bullet extends RectangleComponent
    with HasGameReference, CollisionCallbacks {
  final double angleAtFire;

  Bullet({required Vector2 position, required this.angleAtFire})
    : super(
        position: position,
        size: Vector2(2, 10),
        anchor: Anchor.center,
        angle: angleAtFire,
      );

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox());
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: GameConfig.bulletColorList,
    ).createShader(size.toRect());
    paint.blendMode = BlendMode.screen;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(
      Vector2(0, -1)
        ..rotate(angleAtFire)
        ..scale(GameConfig.bulletSpeed * dt),
    );
    if (position.x < 0 || position.y < 0) {
      removeFromParent();
    }
  }
}
