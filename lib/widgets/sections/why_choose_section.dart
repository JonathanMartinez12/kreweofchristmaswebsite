import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final benefits = [
      _Benefit(
        icon: Icons.verified_user,
        title: 'Licensed & Insured',
        description:
            'Fully licensed and insured for your peace of mind. We follow all safety protocols and industry standards.',
      ),
      _Benefit(
        icon: Icons.star,
        title: 'Expert Team',
        description:
            'Years of experience in holiday lighting design and installation. Our crew is trained, professional, and detail-oriented.',
      ),
      _Benefit(
        icon: Icons.palette,
        title: 'Custom Designs',
        description:
            'Every installation is tailored to your unique vision and property. No cookie-cutter solutions here.',
      ),
      _Benefit(
        icon: Icons.wb_incandescent,
        title: 'Premium LED Lights',
        description:
            'We use commercial-grade, energy-efficient LED lights that are brighter, last longer, and save on electricity.',
      ),
      _Benefit(
        icon: Icons.handyman,
        title: 'Full-Season Support',
        description:
            'From installation to maintenance to takedown, we handle everything so you can focus on enjoying the holidays.',
      ),
      _Benefit(
        icon: Icons.sentiment_satisfied_alt,
        title: '100% Satisfaction',
        description:
            'We don\'t rest until you love your display. Your satisfaction is our top priority.',
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
              // Header
              Text(
                'Why Choose Krewe of Christmas?',
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
                  'We stand out in the Christmas light installation industry with our commitment to excellence, safety, and customer satisfaction.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              // Benefits grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 900;
                  final cardWidth = isNarrow
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 48) / 3;
                  
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: benefits
                        .map(
                          (benefit) => SizedBox(
                            width: cardWidth,
                            child: _BenefitCard(benefit: benefit),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 56),
              // CTA
              PrimaryButton(
                label: 'Get Your Free Quote Today',
                onPressed: () {
                  // TODO: scroll to quote section
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Benefit {
  final IconData icon;
  final String title;
  final String description;

  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _BenefitCard extends StatefulWidget {
  final _Benefit benefit;

  const _BenefitCard({required this.benefit});

  @override
  State<_BenefitCard> createState() => _BenefitCardState();
}

class _BenefitCardState extends State<_BenefitCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 220,
        decoration: BoxDecoration(
          color: _isHovered ? Palette.deepGreen : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? Palette.deepGreen : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? Colors.white.withOpacity(0.2)
                      : Palette.accentGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.benefit.icon,
                  color: _isHovered ? Colors.white : Palette.accentGold,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                widget.benefit.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _isHovered ? Colors.white : Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 8),
              // Description
              Expanded(
                child: Text(
                  widget.benefit.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _isHovered
                            ? Colors.white.withOpacity(0.9)
                            : Palette.textMutedOnLight,
                        height: 1.5,
                        fontSize: 14,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}