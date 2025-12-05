import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

/// Path to the hero background image (local asset).
/// Put your client's house photo at:
/// assets/images/hero_house.jpg
const String kHeroBackgroundImageAsset = 'krewe_of_christmas/assets/images/hero_house.jpg';

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
          // 1) House photo filling the hero
          Positioned.fill(
            child: ClipRRect(
              child: Image.asset(
                kHeroBackgroundImageAsset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // 2) Dark + red/green gradient overlay (Candy Cane vibe)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0E3C24).withOpacity(0.85), // deep green
                    const Color(0xFFA52E2E).withOpacity(0.85), // rich red
                    Colors.black.withOpacity(0.70),            // darker bottom
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // 3) Soft animated fog / glow on top
          const Positioned.fill(
            child: IgnorePointer(
              child: _AnimatedFogBackground(),
            ),
          ),

          // 4) Main content (padding + layout)
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
                      _HeroContent(isMobile: isMobile),
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

class _HeroContent extends StatelessWidget {
  final bool isMobile;

  const _HeroContent({required this.isMobile});

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
            fontWeight: FontWeight.w800,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Experience professional holiday lighting design, installation, '
          'maintenance, and takedown so your home or business shines all season.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment:
              isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'Get a Free Quote',
              onPressed: () {
                // TODO: scroll to quote section
              },
            ),
            PrimaryButton(
              label: 'View Gallery',
              isOutlined: true,
              onPressed: () {
                // TODO: scroll to gallery section
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment:
              isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: const [
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
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

/// Thin animated light bar that sweeps red/green/gold across the top.
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
            final t = _controller.value; // 0 → 1 → 0
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

/// Animated "fog" / glow background using drifting blobs.
class _AnimatedFogBackground extends StatefulWidget {
  const _AnimatedFogBackground();

  @override
  State<_AnimatedFogBackground> createState() =>
      _AnimatedFogBackgroundState();
}

class _AnimatedFogBackgroundState extends State<_AnimatedFogBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
        final t = _controller.value;

        return Stack(
          children: [
            _movingBlob(
              t: t,
              phase: 0.0,
              baseAlignment: const Alignment(-0.8, -0.6),
              amplitude: const Offset(0.3, 0.2),
              size: 280,
              color: const Color(0xFFBEE3FF).withOpacity(0.25),
            ),
            _movingBlob(
              t: t,
              phase: 0.33,
              baseAlignment: const Alignment(0.6, -0.3),
              amplitude: const Offset(0.25, 0.25),
              size: 260,
              color: const Color(0xFFCDE9FF).withOpacity(0.22),
            ),
            _movingBlob(
              t: t,
              phase: 0.66,
              baseAlignment: const Alignment(0.0, 0.4),
              amplitude: const Offset(0.35, 0.15),
              size: 320,
              color: const Color(0xFFEAF4FF).withOpacity(0.25),
            ),
          ],
        );
      },
    );
  }

  Widget _movingBlob({
    required double t,
    required double phase,
    required Alignment baseAlignment,
    required Offset amplitude,
    required double size,
    required Color color,
  }) {
    final angle = 2 * math.pi * (t + phase);
    final dx = amplitude.dx * math.cos(angle);
    final dy = amplitude.dy * math.sin(angle);

    return Align(
      alignment: Alignment(
        baseAlignment.x + dx,
        baseAlignment.y + dy,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }
}
