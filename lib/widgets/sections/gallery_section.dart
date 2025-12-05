import 'package:flutter/material.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: List.generate(
          6,
          (index) => Container(
            width: 120,
            height: 80,
            color: Colors.white12,
            alignment: Alignment.center,
            child: const Text(
              'Photo',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ),
    );
  }
}
