import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final testimonials = [
      _Testimonial(
        quote:
            'They made our house the best-looking one on the street. The whole process was effortless.',
        name: 'Sarah L.',
        detail: 'Residential Client',
      ),
      _Testimonial(
        quote:
            'Our storefront has never looked better. Customers comment on the lights every day.',
        name: 'Mike D.',
        detail: 'Local Business Owner',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Palette.pageBackground,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'What Our Clients Say',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Palette.deepGreen,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (!isMobile)
                    PrimaryButton(
                      label: 'Get a Free Quote',
                      onPressed: () {},
                    ),
                ],
              ),
              if (isMobile) const SizedBox(height: 16),
              if (isMobile)
                PrimaryButton(
                  label: 'Get a Free Quote',
                  onPressed: () {},
                ),
              const SizedBox(height: 24),
              Column(
                children: testimonials
                    .map(
                      (t) => Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: _TestimonialCard(testimonial: t),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Testimonial {
  final String quote;
  final String name;
  final String detail;

  const _Testimonial({
    required this.quote,
    required this.name,
    required this.detail,
  });
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

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
              '“${testimonial.quote}”',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Palette.textOnLight,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              testimonial.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.deepGreen,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              testimonial.detail,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Palette.textMutedOnLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
