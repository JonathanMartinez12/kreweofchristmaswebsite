import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/links.dart';
import '../common/red_button.dart';
import '../layout/responsive_layout.dart';

class QuoteSection extends StatelessWidget {
  const QuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: Palette.deepGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready to Transform Your Home?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Get your free, no-obligation quote today. We\'ll create a custom lighting design that fits your vision and budget.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 18,
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 40),
              const RedButton(
                label: 'Get Your Free Quote',
                isLarge: true,
                onPressed: Links.openQuoteForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
