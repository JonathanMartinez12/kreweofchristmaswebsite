import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      alignment: Alignment.centerLeft,
      child: const Text(
        '© 2025 Krewe of Christmas. All rights reserved.',
        style: TextStyle(color: Colors.white38, fontSize: 12),
      ),
    );
  }
}
