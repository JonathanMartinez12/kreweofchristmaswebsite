import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import 'red_button.dart';  // Import red button

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _mobileMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 10 : 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Row(
                children: [
                  // Logo
                  InkWell(
                    onTap: () {
                      ScrollService.scrollToSection(
                        ScrollService.heroKey,
                        context,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Krewe of Christmas',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  
                  // Desktop navigation
                  if (!isMobile) ...[
                    _NavLink(
                      'Home',
                      onTap: () => ScrollService.scrollToSection(
                        ScrollService.heroKey,
                        context,
                      ),
                    ),
                    _NavLink(
                      'About',
                      onTap: () => ScrollService.scrollToSection(
                        ScrollService.aboutKey,
                        context,
                      ),
                    ),
                    _NavLink(
                      'Services',
                      onTap: () => ScrollService.scrollToSection(
                        ScrollService.servicesKey,
                        context,
                      ),
                    ),
                    _NavLink(
                      'Gallery',
                      onTap: () => ScrollService.scrollToSection(
                        ScrollService.galleryKey,
                        context,
                      ),
                    ),
                    _NavLink(
                      'FAQs',
                      onTap: () => ScrollService.scrollToSection(
                        ScrollService.faqKey,
                        context,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  
                  // RED QUOTE BUTTON (changed from PrimaryButton to RedButton)
                  if (!isMobile)
                    RedButton(
                      label: 'Get a Free Quote',
                      onPressed: () {
                        ScrollService.scrollToSection(
                          ScrollService.quoteKey,
                          context,
                        );
                      },
                    ),
                  
                  // Mobile hamburger menu
                  if (isMobile)
                    IconButton(
                      icon: Icon(
                        _mobileMenuOpen ? Icons.close : Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _mobileMenuOpen = !_mobileMenuOpen;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Keep _NavLink the same...
class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink(this.label, {required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? Palette.accentRed : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _hovered ? 30 : 0,
                decoration: BoxDecoration(
                  color: Palette.accentRed,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}