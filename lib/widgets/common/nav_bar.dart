import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.black87,
      alignment: Alignment.centerLeft,
      child: const Text(
        'Krewe of Christmas',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
