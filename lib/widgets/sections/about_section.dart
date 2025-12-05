import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black87,
      child: const Text(
        'About Krewe of Christmas\n\n'
        'This is placeholder text for the about section.',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
