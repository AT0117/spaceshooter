import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:spaceshooter/constants.dart';

class Planet extends CircleComponent with CollisionCallbacks{
  Planet() : super(
    radius: GameConfig.planetRadius,
    anchor: Anchor.center,
    paint: Paint()..color = GameConfig.planetColor
  );

  @override
  Future<void> onLoad() async{
    super.onLoad();
    add(CircleHitbox());
  }
}