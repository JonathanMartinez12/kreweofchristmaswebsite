import 'package:flutter/material.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: const Text(
        'FAQ\n\nQ: Do you handle takedown?\nA: Yes, after the season.',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
