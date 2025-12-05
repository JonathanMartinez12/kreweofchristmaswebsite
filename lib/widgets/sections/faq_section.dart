import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final faqs = [
      _Faq(
        question: 'When do you start installing Christmas lights?',
        answer:
            'We typically begin installs in early November and continue through early December, depending on availability.',
      ),
      _Faq(
        question: 'Do you provide the lights, or can you use ours?',
        answer:
            'We provide commercial-grade lights for the best reliability, but we can discuss using existing lights on a case-by-case basis.',
      ),
      _Faq(
        question: 'What happens after the holidays?',
        answer:
            'We schedule takedown, carefully remove all lights, and can label/store them for future seasons.',
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
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FAQs',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              ...faqs.map(
                (faq) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _FaqItem(faq: faq),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Faq {
  final String question;
  final String answer;

  const _Faq({
    required this.question,
    required this.answer,
  });
}

class _FaqItem extends StatelessWidget {
  final _Faq faq;

  const _FaqItem({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          faq.question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.deepGreen,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          faq.answer,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Palette.textMutedOnLight,
              ),
        ),
      ],
    );
  }
}
