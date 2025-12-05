import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: Palette.deepGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                'Krewe of Christmas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.textOnDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Professional Christmas light installation – design, install, maintenance, and takedown.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Palette.textMutedOnDark,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} Krewe of Christmas. All rights reserved.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Palette.textMutedOnDark,
                        ),
                  ),
                  if (!isMobile)
                    Text(
                      'Licensed & insured',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Palette.textMutedOnDark,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
