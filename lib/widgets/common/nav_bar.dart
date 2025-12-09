import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import 'primary_button.dart';

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
                  // Logo - clickable to scroll to top
                  InkWell(
                    onTap: () {
                      ScrollService.scrollToSection(
                        ScrollService.heroKey,
                        context,
                      );
                    },
                    child: Text(
                      'Krewe of Christmas',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Palette.deepGreen,
                            fontWeight: FontWeight.w800,
                          ),
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
                  
                  // Quote button (desktop)
                  if (!isMobile)
                    PrimaryButton(
                      label: 'Get a Free Quote',
                      onPressed: () {
                        ScrollService.scrollToSection(
                          ScrollService.quoteKey,
                          context,
                        );
                      },
                    ),
                  
                  // Mobile hamburger menu (for future)
                  if (isMobile)
                    IconButton(
                      icon: Icon(
                        _mobileMenuOpen ? Icons.close : Icons.menu,
                        color: Palette.deepGreen,
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
                  color: _hovered ? Palette.accentRed : Palette.textMutedOnLight,
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