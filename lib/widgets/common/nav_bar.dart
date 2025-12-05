import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import 'primary_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final navItems = [
      'Home',
      'About',
      'Services',
      'Gallery',
      'FAQs',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 10 : 16,
      ),
      decoration: BoxDecoration(
        color: Palette.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.04),
          ),
        ),
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
              if (!isMobile)
                ...navItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Palette.textMutedOnLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (!isMobile) const SizedBox(width: 16),
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
    );
  }
}
