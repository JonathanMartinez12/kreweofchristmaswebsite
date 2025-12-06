import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
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
            'They made our house the best-looking one on the street. The whole process was effortless from start to finish.',
        name: 'Sarah L.',
        detail: 'Residential Client',
        rating: 5,
      ),
      _Testimonial(
        quote:
            'Our storefront has never looked better. Customers comment on the lights every single day. Best investment we made this holiday season!',
        name: 'Mike D.',
        detail: 'Local Business Owner',
        rating: 5,
      ),
      _Testimonial(
        quote:
            'Professional, reliable, and the lights look absolutely stunning. They handled everything and it was completely stress-free.',
        name: 'Jennifer K.',
        detail: 'Residential Client',
        rating: 5,
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
                'What Our Clients Say',
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
                  'Don\'t just take our word for it - hear from our satisfied customers who transformed their homes and businesses.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              // Testimonials Grid
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
              const SizedBox(height: 56),
              // CTA
              PrimaryButton(
                label: 'Get Your Free Quote',
                onPressed: () {
                  ScrollService.scrollToSection(
                    ScrollService.quoteKey,
                    context,
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
  final String quote;
  final String name;
  final String detail;
  final int rating;

  const _Testimonial({
    required this.quote,
    required this.name,
    required this.detail,
    required this.rating,
  });
}

class _TestimonialCard extends StatefulWidget {
  final _Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? Palette.accentGold : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Palette.accentGold.withOpacity(0.15)
                  : Colors.black.withOpacity(0.06),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stars rating
              Row(
                children: List.generate(
                  widget.testimonial.rating,
                  (index) => const Icon(
                    Icons.star,
                    color: Palette.accentGold,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Quote
              Expanded(
                child: Text(
                  '"${widget.testimonial.quote}"',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Palette.textOnLight,
                        height: 1.6,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              // Divider
              Container(
                height: 2,
                width: 40,
                decoration: BoxDecoration(
                  color: Palette.accentRed,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              // Name
              Text(
                widget.testimonial.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              // Detail
              Text(
                widget.testimonial.detail,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Palette.textMutedOnLight,
                      fontSize: 13,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}