import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';
  

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: const BoxDecoration(
        // Light, festive gradient background
        gradient: LinearGradient(
          colors: [
            Color(0xFFFDF7F0), // warm cream
            Color(0xFFE8F3FF), // soft icy blue
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile
              ? const _HeroMobileLayout()
              : const _HeroDesktopLayout(),
        ),
      ),
    );
  }
}

class _HeroDesktopLayout extends StatelessWidget {
  const _HeroDesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 3, child: _HeroCopy()),
        SizedBox(width: 40),
        Expanded(flex: 2, child: _HeroImageCard()),
      ],
    );
  }
}

class _HeroMobileLayout extends StatelessWidget {
  const _HeroMobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeroCopy(centerAligned: true),
        SizedBox(height: 24),
        _HeroImageCard(height: 220),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  final bool centerAligned;

  const _HeroCopy({this.centerAligned = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: centerAligned
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Christmas Light\nInstallation in Your City',
          textAlign: centerAligned ? TextAlign.center : TextAlign.left,
          style: textTheme.displayLarge?.copyWith(
            color: Palette.deepGreen,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Custom holiday lighting design, professional installation, '
          'maintenance, and takedown – so your home or business shines all season.',
          textAlign: centerAligned ? TextAlign.center : TextAlign.left,
          style: textTheme.bodyLarge?.copyWith(
            color: Palette.textMutedOnLight,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment:
              centerAligned ? WrapAlignment.center : WrapAlignment.start,
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
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
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
        Icon(icon, color: Palette.deepGreen, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Palette.textMutedOnLight,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _HeroImageCard extends StatelessWidget {
  final double? height;

  const _HeroImageCard({this.height});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
            width: 2,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [
                Palette.deepGreen,
                Palette.accentRed,
                Palette.accentGold,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text(
              'Hero image placeholder\n(Christmas lights photo here)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
