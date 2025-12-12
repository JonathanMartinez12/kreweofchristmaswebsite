import 'package:flutter/material.dart';

import '../utils/scroll_service.dart';
import '../widgets/common/nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/services_section.dart';
import '../widgets/sections/process_section.dart';
import '../widgets/sections/why_choose_section.dart';
import '../widgets/sections/gallery_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/faq_section.dart';
import '../widgets/sections/quote_section.dart';
import '../widgets/sections/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Store the scroll controller in the ScrollService
    ScrollService.scrollController = _scrollController;

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content with NO top padding (hero goes to very top)
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Each section wrapped with its GlobalKey
                Container(
                  key: ScrollService.heroKey,
                  child: const HeroSection(),
                ),
                Container(
                  key: ScrollService.aboutKey,
                  child: const AboutSection(),
                ),
                Container(
                  key: ScrollService.servicesKey,
                  child: const ServicesSection(),
                ),
                Container(
                  key: ScrollService.processKey,
                  child: const ProcessSection(),
                ),
                Container(
                  key: ScrollService.whyChooseKey,
                  child: const WhyChooseSection(),
                ),
                Container(
                  key: ScrollService.galleryKey,
                  child: const GallerySection(),
                ),
                Container(
                  key: ScrollService.testimonialsKey,
                  child: const TestimonialsSection(),
                ),
                Container(
                  key: ScrollService.faqKey,
                  child: const FAQSection(),
                ),
                Container(
                  key: ScrollService.quoteKey,
                  child: const QuoteSection(),
                ),
                const FooterSection(),
              ],
            ),
          ),

          // Fixed navigation bar OVERLAYS the hero (no gap!)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(),
          ),
        ],
      ),
    );
  }
}