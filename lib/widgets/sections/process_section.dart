import 'package:flutter/material.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black87,
      child: const Text(
        'How It Works\n\n1. Free quote\n2. Design & install\n3. Maintenance\n4. Takedown',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
