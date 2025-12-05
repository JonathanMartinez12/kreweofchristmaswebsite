import 'package:flutter/material.dart';

// imports for your widgets
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavBar(),
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
    );
  }
}
