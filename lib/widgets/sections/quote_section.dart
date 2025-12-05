import 'package:flutter/material.dart';

class QuoteSection extends StatelessWidget {
  const QuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Request a Free Quote',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 8),
          Text(
            'Form goes here (name, email, etc.)',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
