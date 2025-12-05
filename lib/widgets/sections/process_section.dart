import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final steps = [
      _StepData(
        step: '01',
        title: 'Schedule Your Quote',
        description:
            'You reach out with your address and ideas. We discuss your goals and budget.',
      ),
      _StepData(
        step: '02',
        title: 'Design & Proposal',
        description:
            'We design a custom display and send a clear proposal so you know exactly what to expect.',
      ),
      _StepData(
        step: '03',
        title: 'Professional Installation',
        description:
            'Our crew installs your lights, checks every bulb, and sets timers so everything runs smoothly.',
      ),
      _StepData(
        step: '04',
        title: 'Takedown & Storage',
        description:
            'After the holidays, we carefully remove, label, and store your lights for next year.',
      ),
    ];

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
              Text(
                'How It Works',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'A simple, stress-free process from quote to takedown.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
              const SizedBox(height: 32),
              Column(
                children: steps
                    .map((s) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _StepRow(data: s),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepData {
  final String step;
  final String title;
  final String description;

  const _StepData({
    required this.step,
    required this.title,
    required this.description,
  });
}

class _StepRow extends StatelessWidget {
  final _StepData data;

  const _StepRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Palette.deepGreen,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            data.step,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.textMutedOnLight,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
