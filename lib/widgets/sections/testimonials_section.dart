import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/palette.dart';
import '../../utils/links.dart';
import '../layout/responsive_layout.dart';

// Overall star rating shown on the Google Business Profile.
const String _googleRating = '5.0';

// Real reviews copied from the Google Business Profile (Links.googleReviews).
// Reviews that are cut off on Google end with '…'. Long and short reviews are
// paired so each row of cards is roughly the same height.
const List<_Testimonial> _reviews = [
  _Testimonial(
    name: 'Rachel Eggie',
    rating: 5,
    text:
        'We used them for our Christmas lights last year and had such a great experience! Everything looked beautiful, the process was so easy, and the team was amazing to work with. We loved our lights and are excited to use them again this year. Highly recommend!',
  ),
  _Testimonial(
    name: 'Troy Borne',
    rating: 5,
    text:
        'John at Krewe of Christmas did an excellent job installing and removing our Christmas lights. They provided great communication before installation and throughout the process, and they are quick to respond if a bulb burns out…',
  ),
  _Testimonial(
    name: 'Thomas Hebert',
    rating: 5,
    text:
        'This is, without a doubt, a 5-STAR experience and the BEST Christmas lighting company around!…',
  ),
  _Testimonial(
    name: 'Chase Sharp',
    rating: 5,
    text:
        'These guys get the job done quick and easy. The Christmas lights they put on our house look awesome!',
  ),
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
              const SizedBox(height: 24),
              const _RatingSummary(),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final perRow = constraints.maxWidth < 900 ? 1 : 2;
                  final rows = <Widget>[];
                  for (var i = 0; i < _reviews.length; i += perRow) {
                    final rowReviews = _reviews.skip(i).take(perRow).toList();
                    rows.add(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var j = 0; j < perRow; j++) ...[
                            if (j > 0) const SizedBox(width: 32),
                            Expanded(
                              child: j < rowReviews.length
                                  ? _TestimonialCard(
                                      testimonial: rowReviews[j],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (var i = 0; i < rows.length; i++) ...[
                        if (i > 0) const SizedBox(height: 32),
                        rows[i],
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 48),
              OutlinedButton.icon(
                onPressed: () => Links.open(Links.googleReviews),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  size: 18,
                  color: Palette.textOnLight,
                ),
                label: const Text(
                  'See More Reviews on Google',
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

class _RatingSummary extends StatelessWidget {
  const _RatingSummary();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        const Text(
          _googleRating,
          style: TextStyle(
            color: Palette.textOnLight,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Palette.accentGold,
              size: 28,
            ),
          ),
        ),
        const Text(
          'on Google',
          style: TextStyle(
            color: Palette.textMutedOnLight,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _Testimonial {
  final String name;
  final int rating;
  final String text;

  const _Testimonial({
    required this.name,
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
            '"${testimonial.text}"',
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
                  const SizedBox(height: 2),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.google,
                        size: 12,
                        color: Palette.textMutedOnLight,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Google review',
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
        ],
      ),
    );
  }
}
