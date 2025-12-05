import 'package:flutter/material.dart';
import '../../theme/palette.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isOutlined = widget.isOutlined;

    // Base color (uses whatever accentRed is in your current Palette)
    const baseRed = Palette.accentRed;

    final filledGradient = const LinearGradient(
      colors: [
        baseRed,
        Color(0xFF9C2F32), // slightly darker red for depth
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final textColor = isOutlined ? baseRed : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        decoration: _buildDecoration(isOutlined),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      color: textColor,
                    ),
                  ),
                  if (!isOutlined) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: textColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isOutlined) {
    if (isOutlined) {
      return BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Palette.accentRed,
          width: 1.4,
        ),
      );
    }

    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Palette.accentRed,
          Color(0xFF9C2F32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(999),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(_hovered ? 0.18 : 0.12),
          blurRadius: _hovered ? 24 : 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}
