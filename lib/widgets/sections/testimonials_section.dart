import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black87,
      child: const Text(
        '“They made our house look incredible!”\n— Happy Customer',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
