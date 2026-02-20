import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/constants.dart';
import 'package:spaceshooter/spaceshooter.dart';

class Turret extends PositionComponent with HasGameReference<SpaceShooter> {
  late final SpriteComponent rocketSprite;

  Turret() : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    final sprite = await game.loadSprite('rocket.png');
    rocketSprite = SpriteComponent(
      sprite: sprite,
      size: Vector2(25, 75),
      position: Vector2(0, -GameConfig.planetRadius - 10),
      anchor: Anchor.center,
    );
    add(rocketSprite);

    rocketSprite.add(
      MoveEffect.by(
        Vector2(0.5, 0.5),
        EffectController(duration: 0.05, reverseDuration: 0.05, infinite: true),
      ),
    );
  }

  void shoot() {
    game.bulletPool.start();
    final bullet = Bullet(
      position: rocketSprite.absolutePosition,
      angleAtFire: angle,
    );
    game.add(bullet);
    rocketSprite.add(
      MoveEffect.by(
        Vector2(0, 10),
        EffectController(duration: 0.1, reverseDuration: 0.1),
      ),
    );
  }
}
