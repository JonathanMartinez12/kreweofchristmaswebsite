import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final steps = [
      _StepData(
        step: '01',
        title: 'Consultation',
        description:
            'We begin with a detailed consultation to understand your design preferences, the scale of the project, and any unique requirements you have.',
        icon: Icons.phone_in_talk,
      ),
      _StepData(
        step: '02',
        title: 'Design & Planning',
        description:
            'Our experts craft a custom design plan that highlights the unique features of your home while maximizing visual impact.',
        icon: Icons.design_services,
      ),
      _StepData(
        step: '03',
        title: 'Professional Installation',
        description:
            'Using top-quality lights and materials, our team installs your display efficiently and safely, taking care of all the intricate details.',
        icon: Icons.construction,
      ),
      _StepData(
        step: '04',
        title: 'Maintenance',
        description:
            'Throughout the season, we offer routine maintenance to ensure your display remains flawless and shining bright.',
        icon: Icons.build,
      ),
      _StepData(
        step: '05',
        title: 'Removal & Storage',
        description:
            'After the holidays, we handle the safe and timely removal of your lights, ensuring your property is left just as we found it.',
        icon: Icons.inventory,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Text(
                'Our Process',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                    ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'We follow a meticulous process to ensure that every installation is perfect from start to finish.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              // Steps
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 900;
                  if (isNarrow) {
                    // Vertical layout for mobile
                    return Column(
                      children: steps
                          .asMap()
                          .entries
                          .map((entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 32.0),
                                child: _StepCard(
                                  data: entry.value,
                                  isLast: entry.key == steps.length - 1,
                                ),
                              ))
                          .toList(),
                    );
                  } else {
                    // Grid layout for desktop
                    return Wrap(
                      spacing: 24,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: steps
                          .map((step) => SizedBox(
                                width: (constraints.maxWidth - 48) / 3,
                                child: _StepCard(data: step, isLast: false),
                              ))
                          .toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepData {
  final String step;
  final String title;
  final String description;
  final IconData icon;

  const _StepData({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _StepCard extends StatefulWidget {
  final _StepData data;
  final bool isLast;

  const _StepCard({
    required this.data,
    required this.isLast,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Palette.deepGreen.withOpacity(0.15)
                  : Colors.black.withOpacity(0.06),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step number badge
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Palette.accentRed,
                      Palette.accentRed.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.accentRed.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.data.step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Palette.deepGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.data.icon,
                  color: Palette.deepGreen,
                  size: 24,
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                widget.data.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                widget.data.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.textMutedOnLight,
                      height: 1.6,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}