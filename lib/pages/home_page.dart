import 'package:flutter/material.dart';

import '../widgets/common/nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/services_section.dart';
import '../widgets/sections/process_section.dart';
import '../widgets/sections/gallery_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/faq_section.dart';
import '../widgets/sections/quote_section.dart';
import '../widgets/sections/footer_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double _navHeight = 72.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We don't use appBar anymore – we're going to overlay the nav instead
      body: Stack(
        children: [
          // Scrollable content, with padding so it doesn't go under the nav
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: _navHeight),
            child: Column(
              children: const [
                HeroSection(),
                AboutSection(),
                ServicesSection(),
                ProcessSection(),
                GallerySection(),
                TestimonialsSection(),
                FAQSection(),
                QuoteSection(),
                FooterSection(),
              ],
            ),
          ),

          // Fixed, overlayed nav bar with blur + transparency
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: _navHeight,
              child: NavBar(),
            ),
          ),
        ],
      ),
    );
  }
}
