import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Particle {
  double x;
  double y;
  double size;
  double opacity;
  double rotation;
  double rotationSpeed;
  double speedX;
  double speedY;
  bool isTwinkling = false;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.rotation,
    required this.rotationSpeed,
    required this.speedX,
    required this.speedY,
  });

  void update(double width, double height) {
    x += speedX;
    y += speedY;
    rotation += rotationSpeed;

    // Twinkle effect
    if (math.Random().nextDouble() < 0.005) {
      opacity = math.Random().nextDouble() * 0.5 + 0.4;
    } else {
      opacity *= 0.995;
      if (opacity < 0.1) opacity = 0.1;
    }

    // Wrap around
    if (x < -size) x = width + size;
    if (x > width + size) x = -size;
    if (y < -size) y = height + size;
    if (y > height + size) y = -size;
  }
}

class ShootingStar {
  double x;
  double y;
  double length;
  double speed;
  double opacity;
  double angle;

  ShootingStar({
    required this.x,
    required this.y,
    required this.length,
    required this.speed,
    required this.opacity,
    required this.angle,
  });

  bool update() {
    x += math.cos(angle) * speed;
    y += math.sin(angle) * speed;
    opacity -= 0.015;
    return opacity > 0;
  }
}

class ParticleBackground extends StatefulWidget {
  final int particleCount;
  const ParticleBackground({super.key, this.particleCount = 600});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> _particles = [];
  List<ShootingStar> _shootingStars = [];
  ui.Image? _logoImage;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _loadAsset();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        if (mounted) setState(() {});
      })..repeat();

    _startShootingStars();
  }

  Future<void> _loadAsset() async {
    final ByteData data = await rootBundle.load('assets/mpesacrowlogo.png');
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();
    if (mounted) {
      setState(() {
        _logoImage = fi.image;
      });
    }
  }

  void _initParticles(double width, double height) {
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: _random.nextDouble() * width,
        y: _random.nextDouble() * height,
        size: _random.nextDouble() * 6 + 4,
        opacity: _random.nextDouble() * 0.5 + 0.1,
        rotation: _random.nextDouble() * math.pi * 2,
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.02,
        speedX: (_random.nextDouble() - 0.5) * 0.3,
        speedY: (_random.nextDouble() - 0.5) * 0.3,
      );
    });
  }

  void _startShootingStars() {
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 2000 + _random.nextInt(3000)));
      if (!mounted) return false;
      if (_random.nextDouble() > 0.4) {
        setState(() {
          _shootingStars.add(ShootingStar(
            x: _random.nextDouble() * MediaQuery.of(context).size.width,
            y: 0,
            length: _random.nextDouble() * 80 + 40,
            speed: _random.nextDouble() * 10 + 8,
            opacity: 1.0,
            angle: math.pi / 4 + (_random.nextDouble() * 0.2 - 0.1),
          ));
        });
      }
      return true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_logoImage == null) return const SizedBox.expand();
    
    final size = MediaQuery.of(context).size;
    if (_particles.isEmpty) {
      _initParticles(size.width, size.height);
    }

    return CustomPaint(
      size: Size.infinite,
      painter: ParticlePainter(
        particles: _particles,
        shootingStars: _shootingStars,
        image: _logoImage!,
        random: _random,
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final List<ShootingStar> shootingStars;
  final ui.Image image;
  final math.Random random;

  ParticlePainter({
    required this.particles,
    required this.shootingStars,
    required this.image,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    // Source rect for the image (entire image)
    final Rect src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    
    final List<ui.RSTransform> transforms = [];
    final List<Rect> rects = [];
    final List<Color> colors = [];

    for (var p in particles) {
      p.update(size.width, size.height);
      
      final double sc = p.size / math.max(image.width, image.height);
      final double rotation = p.rotation;
      
      // Calculate transform
      transforms.add(ui.RSTransform.fromComponents(
        rotation: rotation,
        scale: sc,
        anchorX: image.width / 2,
        anchorY: image.height / 2,
        translateX: p.x,
        translateY: p.y,
      ));
      
      rects.add(src);
      colors.add(Colors.white.withOpacity(p.opacity));
    }

    // Draw all particles in one efficient batch
    canvas.drawAtlas(
      image,
      transforms,
      rects,
      colors,
      BlendMode.modulate,
      null,
      Paint(),
    );

    // Draw shooting stars
    final Paint starPaint = Paint()..strokeCap = StrokeCap.round;
    for (int i = shootingStars.length - 1; i >= 0; i--) {
      final s = shootingStars[i];
      if (!s.update()) {
        shootingStars.removeAt(i);
        continue;
      }

      final double endX = s.x - math.cos(s.angle) * s.length;
      final double endY = s.y - math.sin(s.angle) * s.length;

      final Gradient gradient = LinearGradient(
        colors: [
          Colors.white.withOpacity(s.opacity),
          Colors.white.withOpacity(0),
        ],
        begin: Alignment.centerRight, // Approximate based on angle
        end: Alignment.centerLeft,
      );

      starPaint.shader = ui.Gradient.linear(
        Offset(s.x, s.y),
        Offset(endX, endY),
        [Colors.white.withOpacity(s.opacity), Colors.white.withOpacity(0)],
      );
      starPaint.strokeWidth = 2.0;
      
      canvas.drawLine(Offset(s.x, s.y), Offset(endX, endY), starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
