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
      color: const Color.fromARGB(255, 242, 239, 229),  // Cream/off-white color
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 32,
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
                      color: Palette.textOnLight,  // Dark text
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Professional Christmas light installation – design, install, maintenance, and takedown.',
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.textMutedOnLight,  // Gray text
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 24),
              
              // Copyright and Licensed section
              if (isMobile)
                Column(
                  children: [
                    Text(
                      '© ${DateTime.now().year} Krewe of Christmas. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Licensed & insured',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
                          ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© ${DateTime.now().year} Krewe of Christmas. All rights reserved.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
                          ),
                    ),
                    Text(
                      'Licensed & insured',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Palette.textMutedOnLight,
                            fontSize: 14,
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