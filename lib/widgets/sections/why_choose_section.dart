import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final reasons = [
      _Reason(
        icon: Icons.verified_user,
        title: 'Licensed & Insured',
        description: 'Fully licensed and insured for your peace of mind.',
      ),
      _Reason(
        icon: Icons.design_services,
        title: 'Custom Designs',
        description: 'Every installation is tailored to your property and style.',
      ),
      _Reason(
        icon: Icons.military_tech,
        title: 'Commercial Grade',
        description: 'We use only premium, weather-resistant LED lights.',
      ),
      _Reason(
        icon: Icons.engineering,
        title: 'Full-Service',
        description: 'From design to takedown, we handle everything.',
      ),
      _Reason(
        icon: Icons.handshake,
        title: 'Satisfaction Guaranteed',
        description: 'We stand behind our work with a 100% satisfaction guarantee.',
      ),
      _Reason(
        icon: Icons.build_circle,
        title: 'Maintenance Included',
        description: 'If a bulb goes out, we fix it at no extra charge.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
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
                'Why Choose Us',
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
                  'We\'re committed to delivering exceptional service and stunning results, every single time.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 900;
                  return Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: reasons
                        .map(
                          (reason) => SizedBox(
                            width: isNarrow
                                ? constraints.maxWidth
                                : (constraints.maxWidth - 64) / 3,
                            child: _ReasonCard(reason: reason),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Reason {
  final IconData icon;
  final String title;
  final String description;

  const _Reason({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _ReasonCard extends StatelessWidget {
  final _Reason reason;

  const _ReasonCard({required this.reason});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon container with proper background
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Palette.deepGreen.withOpacity(0.1),  // Light mint background
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            reason.icon,
            color: Palette.deepGreen,  // Mint green icon
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          reason.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Palette.textOnLight,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          reason.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Palette.textMutedOnLight,
                fontSize: 14,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}