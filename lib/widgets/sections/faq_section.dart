import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final faqs = [
      _FAQ(
        question: 'When do you start installing Christmas lights?',
        answer:
            'We typically begin installations in early November and continue through mid-December. Book early to secure your preferred installation date!',
      ),
      _FAQ(
        question: 'Do you provide the lights, or can you use ours?',
        answer:
            'We provide all lights, extension cords, and equipment as part of our service. We use commercial-grade LED lights that are brighter and more durable than consumer options.',
      ),
      _FAQ(
        question: 'What happens after the holidays?',
        answer:
            'We return in early January to carefully remove all lights. We label and store them in our climate-controlled facility, so they\'re ready to go for next season.',
      ),
      _FAQ(
        question: 'Are you licensed and insured?',
        answer:
            'Yes! We are fully licensed, insured, and bonded. Your property and our team are protected throughout the entire process.',
      ),
      _FAQ(
        question: 'How much does installation cost?',
        answer:
            'Pricing varies based on the size of your property and complexity of design. Most residential installations range from \$800-\$3,000. Contact us for a free quote!',
      ),
      _FAQ(
        question: 'Do you offer maintenance during the holiday season?',
        answer:
            'Absolutely! If any bulbs go out or connections loosen, just give us a call. We include maintenance visits in our service at no extra charge.',
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
            children: [
              Text(
                'Frequently Asked Questions',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.accentRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
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
              ...faqs.map((faq) => _FAQItem(faq: faq)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQ {
  final String question;
  final String answer;

  const _FAQ({
    required this.question,
    required this.answer,
  });
}

class _FAQItem extends StatefulWidget {
  final _FAQ faq;

  const _FAQItem({required this.faq});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5, // 180 degrees (0.5 * 360 = 180)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded ? Palette.deepGreen : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _isExpanded
                ? Palette.deepGreen.withOpacity(0.1)
                : Colors.black.withOpacity(0.04),
            blurRadius: _isExpanded ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: _toggleExpanded,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.faq.question,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Palette.deepGreen,  // GREEN QUESTIONS
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                  ),
                  // Animated rotating arrow
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Palette.deepGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Palette.deepGreen,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              // Animated expansion for answer
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    widget.faq.answer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.textMutedOnLight,
                          fontSize: 16,
                          height: 1.6,
                        ),
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}