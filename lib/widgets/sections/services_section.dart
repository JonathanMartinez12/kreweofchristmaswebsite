import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(
            '• Residential installs\n'
            '• Commercial installs\n'
            '• Takedown & storage',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
