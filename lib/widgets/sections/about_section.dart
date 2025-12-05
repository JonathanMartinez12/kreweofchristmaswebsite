import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: Palette.pageBackground,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with CTA
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'About Krewe of Christmas',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Palette.deepGreen,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (!isMobile)
                    PrimaryButton(
                      label: 'Get a Free Quote',
                      onPressed: () {
                        // TODO: scroll to quote section
                      },
                    ),
                ],
              ),
              if (isMobile) const SizedBox(height: 16),
              if (isMobile)
                PrimaryButton(
                  label: 'Get a Free Quote',
                  onPressed: () {
                    // TODO: scroll to quote section
                  },
                ),
              const SizedBox(height: 24),
              Text(
                'Krewe of Christmas is a locally owned holiday lighting company '
                'specializing in custom designs for homes and businesses. From the '
                'first design call to takedown after the season, our team handles every '
                'detail so you can simply enjoy the magic.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'We use commercial-grade lights and professional installation methods '
                'to keep your display bright, safe, and reliable all season long.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
