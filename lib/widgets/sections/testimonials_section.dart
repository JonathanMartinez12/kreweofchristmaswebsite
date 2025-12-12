import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final testimonials = [
      _Testimonial(
        name: 'Sarah Johnson',
        location: 'Baton Rouge, LA',
        rating: 5,
        text:
            'Absolutely stunning! Our home has never looked better. The team was professional, punctual, and the installation was flawless.',
      ),
      _Testimonial(
        name: 'Michael Chen',
        location: 'Baton Rouge, LA',
        rating: 5,
        text:
            'We\'ve used them for 3 years now. They store everything and make it so easy. Highly recommend!',
      ),
      _Testimonial(
        name: 'Emily Rodriguez',
        location: 'Baton Rouge, LA',
        rating: 5,
        text:
            'Great communication, fair pricing, and beautiful results. Our neighbors are jealous!',
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
                'What Our Clients Say',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.accentRed,  // BRIGHT RED HEADER
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'Don\'t just take our word for it—hear from our satisfied customers.',
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
                    children: testimonials
                        .map(
                          (testimonial) => SizedBox(
                            width: isNarrow
                                ? constraints.maxWidth
                                : (constraints.maxWidth - 64) / 3,
                            child: _TestimonialCard(testimonial: testimonial),
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

class _Testimonial {
  final String name;
  final String location;
  final int rating;
  final String text;

  const _Testimonial({
    required this.name,
    required this.location,
    required this.rating,
    required this.text,
  });
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              testimonial.rating,
              (index) => const Icon(
                Icons.star,
                color: Palette.accentGold,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            testimonial.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Palette.textMutedOnLight,
                  fontSize: 15,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Palette.deepGreen,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    testimonial.name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: const TextStyle(
                      color: Palette.textOnLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    testimonial.location,
                    style: TextStyle(
                      color: Palette.textMutedOnLight,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}