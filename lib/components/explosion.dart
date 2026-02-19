import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

class Explosion extends SpriteAnimationComponent with HasGameReference {
  Explosion({required Vector2 position})
    : super(
        position: position,
        size: Vector2.all(50),
        anchor: Anchor.center,
        removeOnFinish: true,
      );

  @override
  FutureOr<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
        loop: false,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    paint.blendMode = BlendMode.screen;
    super.render(canvas);
  }
}
