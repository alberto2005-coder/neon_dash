import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class NeonParticles extends ParticleSystemComponent {
  NeonParticles({
    required Vector2 position,
    required Color color,
    int count = 10,
  }) : super(
          position: position,
          particle: Particle.generate(
            count: count,
            lifespan: 0.5,
            generator: (i) => AcceleratedParticle(
              acceleration: Vector2(0, 200),
              speed: Vector2(
                (Random().nextDouble() - 0.5) * 300,
                (Random().nextDouble() - 1.0) * 300,
              ),
              child: CircleParticle(
                radius: 1.5 + Random().nextDouble() * 2,
                paint: Paint()
                  ..color = color
                  ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5),
              ),
            ),
          ),
        );
}
