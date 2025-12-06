import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final faqs = [
      _Faq(
        question: 'When do you start installing Christmas lights?',
        answer:
            'We typically begin installs in early November and continue through early December, depending on availability. We recommend booking early to secure your preferred installation date, as our schedule fills up quickly during peak season.',
      ),
      _Faq(
        question: 'Do you provide the lights, or can you use ours?',
        answer:
            'We provide commercial-grade LED lights for the best reliability, brightness, and energy efficiency. These lights are professionally maintained and tested before each season. While we can discuss using existing lights on a case-by-case basis, we recommend our premium lights for the best results.',
      ),
      _Faq(
        question: 'What happens after the holidays?',
        answer:
            'We schedule takedown in early January, carefully remove all lights and decorations, and can label and store them in climate-controlled facilities for future seasons. This ensures your lights are protected and ready to go for next year without any hassle on your part.',
      ),
      _Faq(
        question: 'Are you licensed and insured?',
        answer:
            'Yes! We are fully licensed and insured for your peace of mind. Our team follows all safety protocols and industry standards to ensure a safe installation process for both our crew and your property.',
      ),
      _Faq(
        question: 'How much does installation cost?',
        answer:
            'Pricing varies based on the size of your property, complexity of the design, and the type of lights used. We offer free quotes and will work with you to create a display that fits your budget. Contact us today for a personalized estimate!',
      ),
      _Faq(
        question: 'Do you offer maintenance during the holiday season?',
        answer:
            'Absolutely! We offer routine maintenance throughout the season to ensure your display stays flawless. If any lights go out or need adjustment, just give us a call and we\'ll take care of it promptly.',
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
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Text(
                'Frequently Asked Questions',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Got questions? We\'ve got answers. Find everything you need to know about our Christmas light installation services.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                      fontSize: 18,
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 48),
              // FAQ Items with accordions
              ...faqs.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _FaqItem(
                        faq: entry.value,
                        index: entry.key,
                      ),
                    ),
                  ),
              const SizedBox(height: 48),
              // CTA
              Text(
                'Still have questions?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
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

class _Faq {
  final String question;
  final String answer;

  const _Faq({
    required this.question,
    required this.answer,
  });
}

class _FaqItem extends StatefulWidget {
  final _Faq faq;
  final int index;

  const _FaqItem({
    required this.faq,
    required this.index,
  });

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _isExpanded ? Palette.pageBackground : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded ? Palette.accentRed : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          if (_isExpanded)
            BoxShadow(
              color: Palette.accentRed.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: InkWell(
        onTap: _toggleExpansion,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question with icon
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.faq.question,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Palette.deepGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _isExpanded
                            ? Palette.accentRed
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.add,
                        color: _isExpanded ? Colors.white : Palette.deepGreen,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              // Answer (animated)
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    widget.faq.answer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.textMutedOnLight,
                          height: 1.6,
                          fontSize: 15,
                        ),
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