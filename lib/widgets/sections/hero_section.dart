import 'dart:math';
import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

const String kHeroBackgroundImageAsset = 'assets/images/hero_house.jpg';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return SizedBox(
      width: double.infinity,
      height: isMobile ? 520 : 620,
      child: Stack(
        children: [
          // 1) House photo – main visual
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(kHeroBackgroundImageAsset),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),

          // 2) VERY subtle red/green gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0E3C24).withOpacity(0.30),
                    const Color(0xFFA52E2E).withOpacity(0.30),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // 2.5) FALLING SNOW! ❄️
          const Positioned.fill(
            child: _FallingSnow(),
          ),

          // 3) Main content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 80 : 120,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _AnimatedLightBar(),
                      const SizedBox(height: 32),
                      _HeroText(isMobile: isMobile),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============ FALLING SNOW WIDGET ============
class _FallingSnow extends StatefulWidget {
  const _FallingSnow();

  @override
  State<_FallingSnow> createState() => _FallingSnowState();
}

class _FallingSnowState extends State<_FallingSnow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Snowflake> _snowflakes = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    for (int i = 0; i < 50; i++) {
      _snowflakes.add(_Snowflake(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 4 + 2,
        speed: _random.nextDouble() * 0.5 + 0.3,
        drift: _random.nextDouble() * 0.2 - 0.1,
        opacity: _random.nextDouble() * 0.6 + 0.4,
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _SnowPainter(
            snowflakes: _snowflakes,
            animationValue: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Snowflake {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double drift;
  final double opacity;

  _Snowflake({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.drift,
    required this.opacity,
  });
}

class _SnowPainter extends CustomPainter {
  final List<_Snowflake> snowflakes;
  final double animationValue;

  _SnowPainter({
    required this.snowflakes,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (final flake in snowflakes) {
      final currentY = ((flake.y + animationValue * flake.speed) % 1.0) * size.height;
      final currentX = (flake.x + sin(animationValue * 2 * pi + flake.x * 10) * flake.drift) * size.width;

      paint.color = Colors.white.withOpacity(flake.opacity);

      canvas.drawCircle(
        Offset(currentX, currentY),
        flake.size,
        paint,
      );

      if (flake.size > 4) {
        paint.color = Colors.white.withOpacity(flake.opacity * 0.3);
        canvas.drawCircle(
          Offset(currentX, currentY),
          flake.size * 1.5,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_SnowPainter oldDelegate) => true;
}

// ============ HERO TEXT ============
class _HeroText extends StatelessWidget {
  final bool isMobile;

  const _HeroText({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Christmas Light\nInstallation in Your City',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontSize: isMobile ? 42 : null,
          ),
        ),
        const SizedBox(height: 20),
        
        Text(
          'Experience professional holiday lighting design, installation, '
          'maintenance, and takedown so your home or business shines all season.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(0.95),
            fontSize: isMobile ? 16 : 22,
          ),
        ),
        const SizedBox(height: 28),
        
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'Get a Free Quote',
              onPressed: () {
                ScrollService.scrollToSection(
                  ScrollService.quoteKey,
                  context,
                );
              },
            ),
            PrimaryButton(
              label: 'View Gallery',
              isOutlined: true,
              onPressed: () {
                ScrollService.scrollToSection(
                  ScrollService.galleryKey,
                  context,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _HeroBadge(
              icon: Icons.check_circle,
              label: 'Licensed & insured',
            ),
            _HeroBadge(
              icon: Icons.check_circle,
              label: 'Custom designs included',
            ),
          ],
        ),
      ],
    );
  }
}

// ============ HERO BADGE ============
class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroBadge({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============ ANIMATED LIGHT BAR ============
class _AnimatedLightBar extends StatefulWidget {
  const _AnimatedLightBar();

  @override
  State<_AnimatedLightBar> createState() => _AnimatedLightBarState();
}

class _AnimatedLightBarState extends State<_AnimatedLightBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value;
            final beginAlignment = Alignment(-1.5 + 3 * t, 0);
            final endAlignment = Alignment(1.5 + 3 * t, 0);

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Palette.deepGreen,
                    Palette.accentRed,
                    Palette.accentGold,
                    Palette.deepGreen,
                  ],
                  begin: beginAlignment,
                  end: endAlignment,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}