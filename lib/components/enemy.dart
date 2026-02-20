import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/components/explosion.dart';
import 'package:spaceshooter/components/planet.dart';
import 'package:spaceshooter/constants.dart';
import 'package:spaceshooter/spaceshooter.dart';

class Enemy extends SpriteComponent
    with HasGameReference<SpaceShooter>, CollisionCallbacks {
  Enemy({required Vector2 position})
    : super(position: position, size: Vector2.all(50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('spaceship.png');
    add(RectangleHitbox());
    lookAt(game.size / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 target = game.size / 2;
    Vector2 direction = (target - position).normalized();
    position += direction * GameConfig.enemySpeed * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      FlameAudio.play('explosion.mp3');
      game.add(Explosion(position: position.clone()));
      removeFromParent();
      other.removeFromParent();
      game.incrementScore();
    }

    if (other is Planet) {
      FlameAudio.play('gameover.mp3');
      game.overlays.add('GameOverMenu');
      game.pauseEngine();
    }
  }
}
