import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A service that manages smooth scrolling to different sections of the page
class ScrollService {
  // Global keys for each section
  static final GlobalKey heroKey = GlobalKey();
  static final GlobalKey aboutKey = GlobalKey();
  static final GlobalKey servicesKey = GlobalKey();
  static final GlobalKey processKey = GlobalKey();
  static final GlobalKey whyChooseKey = GlobalKey();
  static final GlobalKey galleryKey = GlobalKey();
  static final GlobalKey testimonialsKey = GlobalKey();
  static final GlobalKey faqKey = GlobalKey();
  static final GlobalKey quoteKey = GlobalKey();

  // Store the scroll controller from HomePage
  static ScrollController? scrollController;

  /// Smoothly scrolls to a section by its key
  static void scrollToSection(GlobalKey key, BuildContext context) {
    try {
      if (scrollController == null) {
        print('ScrollController is null');
        return;
      }

      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        print('RenderBox is null');
        return;
      }

      // Get the position of the section relative to the scrollable area
      final position = renderBox.localToGlobal(Offset.zero).dy;
      
      // Offset to account for the fixed navbar (72px) and current scroll position
      const navbarHeight = 72.0;
      final currentScroll = scrollController!.position.pixels;
      final targetPosition = currentScroll + position - navbarHeight;

      scrollController!.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      print('Scroll error: $e');
    }
  }

  /// Scroll to a specific section by name
  static void scrollToSectionByName(String sectionName, BuildContext context) {
    final key = _getSectionKey(sectionName);
    if (key != null) {
      scrollToSection(key, context);
    }
  }

  /// Get the GlobalKey for a section by name
  static GlobalKey? _getSectionKey(String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'home':
        return heroKey;
      case 'about':
        return aboutKey;
      case 'services':
        return servicesKey;
      case 'process':
        return processKey;
      case 'why choose':
        return whyChooseKey;
      case 'gallery':
        return galleryKey;
      case 'testimonials':
        return testimonialsKey;
      case 'faqs':
        return faqKey;
      case 'quote':
        return quoteKey;
      default:
        return null;
    }
  }
}