import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final steps = [
      _Step(
        number: '1',
        title: 'Free Consultation',
        description:
            'We discuss your vision, budget, and property details to create a custom lighting plan.',
      ),
      _Step(
        number: '2',
        title: 'Design & Quote',
        description:
            'Receive a detailed proposal with design mockups and transparent pricing.',
      ),
      _Step(
        number: '3',
        title: 'Professional Installation',
        description:
            'Our team installs your display using commercial-grade materials and safety practices.',
      ),
      _Step(
        number: '4',
        title: 'Enjoy the Season',
        description:
            'Sit back and enjoy your stunning display. We handle maintenance if needed.',
      ),
      _Step(
        number: '5',
        title: 'Takedown & Storage',
        description:
            'After the holidays, we carefully remove and store your lights for next year.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Palette.pageBackground,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Our Process',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.accentRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'From initial consultation to post-season takedown, we make the entire process effortless for you.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              
              // TIMELINE VIEW (desktop)
              if (!isMobile)
                _TimelineDesktop(steps: steps)
              else
                // VERTICAL VIEW (mobile)
                _TimelineMobile(steps: steps),
            ],
          ),
        ),
      ),
    );
  }
}

class _Step {
  final String number;
  final String title;
  final String description;

  const _Step({
    required this.number,
    required this.title,
    required this.description,
  });
}

// ============ DESKTOP TIMELINE ============
class _TimelineDesktop extends StatelessWidget {
  final List<_Step> steps;

  const _TimelineDesktop({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timeline connector line
        Stack(
          alignment: Alignment.center,
          children: [
            // Horizontal line connecting all circles
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.deepGreen,
                    Palette.deepGreen,
                    Palette.accentRed,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Number circles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: steps.map((step) {
                return Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Palette.deepGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.deepGreen.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      step.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Step details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      step.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Palette.textOnLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      step.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ============ MOBILE TIMELINE ============
class _TimelineMobile extends StatelessWidget {
  final List<_Step> steps;

  const _TimelineMobile({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline column with circle and line
              Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Palette.deepGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.deepGreen.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        step.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Palette.deepGreen.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : 32,
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Palette.textOnLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Palette.textMutedOnLight,
                              fontSize: 15,
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}