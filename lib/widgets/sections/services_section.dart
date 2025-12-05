import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final services = [
      _Service(
        title: 'Residential Installations',
        description:
            'Custom roofline, trees, and yard displays designed to fit your home and budget.',
      ),
      _Service(
        title: 'Commercial & Businesses',
        description:
            'Make your storefront, office, or property stand out with a professional holiday display.',
      ),
      _Service(
        title: 'Takedown & Storage',
        description:
            'After the season, we carefully remove, label, and store your lights for next year.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Services',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'From simple rooflines to full property designs, we provide end-to-end holiday lighting services.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 800;
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: services
                        .map(
                          (service) => SizedBox(
                            width: isNarrow
                                ? constraints.maxWidth
                                : (constraints.maxWidth - 48) / 3,
                            child: _ServiceCard(service: service),
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

class _Service {
  final String title;
  final String description;

  const _Service({
    required this.title,
    required this.description,
  });
}

class _ServiceCard extends StatelessWidget {
  final _Service service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Palette.deepGreen,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Palette.textMutedOnLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
