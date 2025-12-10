import 'package:flutter/material.dart';

import '../../theme/palette.dart';

class RedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLarge;

  const RedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLarge = false,
  });

  @override
  State<RedButton> createState() => _RedButtonState();
}

class _RedButtonState extends State<RedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.accentRed,  // BRIGHT RED
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: widget.isLarge ? 40 : 32,
              vertical: widget.isLarge ? 20 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),  // Rounded like green buttons
            ),
            elevation: _isHovered ? 8 : 4,
            shadowColor: Palette.accentRed.withOpacity(0.4),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.isLarge ? 20 : 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}