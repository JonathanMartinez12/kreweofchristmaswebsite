import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/palette.dart';
import '../../utils/links.dart';
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
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _SocialIcon(
                    icon: FontAwesomeIcons.instagram,
                    tooltip: 'Instagram',
                    url: Links.instagram,
                  ),
                  SizedBox(width: 12),
                  _SocialIcon(
                    icon: FontAwesomeIcons.google,
                    tooltip: 'Google Reviews',
                    url: Links.googleReviews,
                  ),
                ],
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
                    const SizedBox(height: 8),
                    const _PrivacyLink(),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _PrivacyLink(),
                        const SizedBox(width: 24),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final FaIconData icon;
  final String tooltip;
  final String url;

  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Palette.deepGreen,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Links.open(url),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: FaIcon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrivacyLink extends StatelessWidget {
  const _PrivacyLink();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: Links.openPrivacyPolicy,
        child: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Palette.textMutedOnLight,
            fontSize: 14,
            decoration: TextDecoration.underline,
            decorationColor: Palette.textMutedOnLight,
          ),
        ),
      ),
    );
  }
}
