import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Gallery',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Palette.deepGreen,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (!isMobile)
                    PrimaryButton(
                      label: 'Get a Free Quote',
                      onPressed: () {},
                    ),
                ],
              ),
              if (isMobile) const SizedBox(height: 16),
              if (isMobile)
                PrimaryButton(
                  label: 'Get a Free Quote',
                  onPressed: () {},
                ),
              const SizedBox(height: 16),
              Text(
                'A few examples of homes and businesses we’ve decorated. These will be replaced with your actual project photos.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 800;
                  final itemWidth = isNarrow
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 24) / 2;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: itemWidth,
                        height: 220,
                        child: _GalleryPlaceholderCard(index: index + 1),
                      ),
                    ),
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

class _GalleryPlaceholderCard extends StatelessWidget {
  final int index;

  const _GalleryPlaceholderCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Palette.deepGreen,
              Palette.accentRed,
              Palette.accentGold,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            'Project photo $index\n(Christmas lights here)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
