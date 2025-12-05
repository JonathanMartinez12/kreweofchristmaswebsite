import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import 'primary_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 10 : 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10), // more see-through
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Row(
                children: [
                  Text(
                    'Krewe of Christmas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Palette.deepGreen,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  if (!isMobile) ...const [
                    _NavLink('Home'),
                    _NavLink('About'),
                    _NavLink('Services'),
                    _NavLink('Gallery'),
                    _NavLink('FAQs'),
                    SizedBox(width: 16),
                  ],
                  PrimaryButton(
                    label: 'Get a Free Quote',
                    onPressed: () {
                      // TODO: scroll to quote section
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;

  const _NavLink(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Palette.textMutedOnLight,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
