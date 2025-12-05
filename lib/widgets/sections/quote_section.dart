import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class QuoteSection extends StatelessWidget {
  const QuoteSection({super.key});

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
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request a Free Quote',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Share a few details about your home or business and we’ll follow up '
                'with a custom quote.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _QuoteTextField(label: 'Name'),
                      const SizedBox(height: 12),
                      _QuoteTextField(label: 'Email'),
                      const SizedBox(height: 12),
                      _QuoteTextField(label: 'Phone'),
                      const SizedBox(height: 12),
                      _QuoteTextField(
                        label: 'Address or neighborhood',
                      ),
                      const SizedBox(height: 12),
                      _QuoteTextField(
                        label: 'Tell us about your project',
                        maxLines: 4,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: PrimaryButton(
                          label: 'Submit Request',
                          onPressed: () {
                            // TODO: connect to backend or form handler
                          },
                        ),
                      ),
                    ],
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

class _QuoteTextField extends StatelessWidget {
  final String label;
  final int maxLines;

  const _QuoteTextField({
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
      ),
    );
  }
}
