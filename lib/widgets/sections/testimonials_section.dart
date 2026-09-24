import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/palette.dart';
import '../../utils/links.dart';
import '../layout/responsive_layout.dart';

// Real reviews copied from the Google Business Profile (Links.googleReviews).
// Add entries here to show them as cards above the Google button.
const List<_Testimonial> _reviews = [
  // _Testimonial(
  //   name: 'Reviewer name',
  //   location: 'Baton Rouge, LA',
  //   rating: 5,
  //   text: 'Review text copied from Google.',
  // ),
];

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

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
                  'Don\'t just take our word for it—see what our customers say on Google.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              if (_reviews.isNotEmpty) ...[
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 900;
                    return Wrap(
                      spacing: 32,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: _reviews
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
                const SizedBox(height: 48),
              ],
              OutlinedButton.icon(
                onPressed: () => Links.open(Links.googleReviews),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  size: 18,
                  color: Palette.textOnLight,
                ),
                label: const Text(
                  'Read Our Reviews on Google',
                  style: TextStyle(
                    color: Palette.textOnLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFDADCE0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
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
            color: Colors.black.withValues(alpha: 0.06),
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