import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ParticleGenerator {
  static Random random = Random();

  static ParticleSystemComponent createExplosion(Vector2 position) {
    return ParticleSystemComponent(
      position: position,
      particle: Particle.generate(
        count: 15,
        lifespan: 0.8,
        generator: (i) {
          final speed = Vector2(
            (random.nextDouble() - 0.5) * 200,
            (random.nextDouble() - 0.5) * 200,
          );

          return AcceleratedParticle(
            acceleration: speed * -0.5,
            speed: speed,
            child: CircleParticle(
              radius: 1.5,
              paint: Paint()..color = Colors.white,
            ),
          );
        },
      ),
    );
  }
}
