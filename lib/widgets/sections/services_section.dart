import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final services = [
      _Service(
        icon: Icons.home,
        title: 'Residential Installations',
        description:
            'Custom roofline, trees, and yard displays designed to fit your home and budget.',
        features: [
          'Custom design consultation',
          'Professional installation',
          'Premium LED lights',
          'Timer setup included',
        ],
      ),
      _Service(
        icon: Icons.business,
        title: 'Commercial & Businesses',
        description:
            'Make your storefront, office, or property stand out with a professional holiday display.',
        features: [
          'Brand-aligned designs',
          'Large-scale installations',
          'Maintenance throughout season',
          'Energy-efficient solutions',
        ],
      ),
      _Service(
        icon: Icons.inventory_2,
        title: 'Takedown & Storage',
        description:
            'After the season, we carefully remove, label, and store your lights for next year.',
        features: [
          'Careful removal process',
          'Professional labeling',
          'Climate-controlled storage',
          'Ready for next season',
        ],
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered header
              Text(
                'Our Services',
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
                  'From simple rooflines to full property designs, we provide end-to-end holiday lighting services that bring your vision to life.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              // Service cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 900;
                  return Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: services
                        .map(
                          (service) => SizedBox(
                            width: isNarrow
                                ? constraints.maxWidth
                                : (constraints.maxWidth - 64) / 3,
                            child: _ServiceCard(service: service),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 56),
              PrimaryButton(
                label: 'Get Your Free Quote',
                onPressed: () {
                  // TODO scroll to quote section
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
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;

  const _Service({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });
}

class _ServiceCard extends StatefulWidget {
  final _Service service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? Palette.accentRed : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Palette.accentRed.withOpacity(0.15)
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
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Palette.accentRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.service.icon,
                  color: Palette.accentRed,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                widget.service.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                widget.service.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.textMutedOnLight,
                      height: 1.6,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 20),
              // Features list
              ...widget.service.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Palette.accentGold,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}