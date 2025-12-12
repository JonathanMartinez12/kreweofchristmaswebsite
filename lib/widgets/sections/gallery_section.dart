import 'package:flutter/material.dart';
import 'dart:async';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  bool _showFullGallery = false;
  int _currentPage = 0;
  Timer? _autoPlayTimer;
  final PageController _pageController = PageController();

  final List<String> _allImages = [
    'assets/images/gallery/IMG_0820.jpeg',
    'assets/images/gallery/IMG_0821.jpeg',
    'assets/images/gallery/IMG_0822.jpeg',
    'assets/images/gallery/IMG_0823.jpeg',
    'assets/images/gallery/IMG_0824.jpeg',
    'assets/images/gallery/IMG_0825.jpeg',
    'assets/images/gallery/IMG_0826.jpeg',
    'assets/images/gallery/IMG_0827.jpeg',
    'assets/images/gallery/IMG_0828.jpeg',
    'assets/images/gallery/IMG_0829.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_showFullGallery && _pageController.hasClients) {
        final nextPage = (_currentPage + 1) % _getPageCount();
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  int _getPageCount() {
    return (_allImages.length / 3).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              Text(
                'Our Work',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Palette.accentRed,  // BRIGHT RED HEADER
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 36 : 48,
                    ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'See how we\'ve transformed homes across Baton Rouge with our professional Christmas light installations.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Palette.textMutedOnLight,
                        fontSize: isMobile ? 16 : 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 48),

              // Carousel
              if (!_showFullGallery) ...[
                SizedBox(
                  height: isMobile ? 400 : 500,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _getPageCount(),
                    itemBuilder: (context, pageIndex) {
                      return _buildCarouselPage(pageIndex, isMobile);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_getPageCount(), (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 32 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Palette.deepGreen
                            : Palette.deepGreen.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],

              // Full gallery
              if (_showFullGallery) ...[
                _buildFullGallery(isMobile),
              ],

              const SizedBox(height: 32),

              // RED "View Full Gallery" button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showFullGallery = !_showFullGallery;
                    if (_showFullGallery) {
                      _autoPlayTimer?.cancel();
                    } else {
                      _startAutoPlay();
                    }
                  });
                },
                icon: Icon(
                  _showFullGallery
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                label: Text(
                  _showFullGallery ? 'Show Less' : 'View Full Gallery',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.accentRed,  // BRIGHT RED BUTTON
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Green CTA button
              PrimaryButton(
                label: 'Get Your Free Quote',
                onPressed: () {
                  ScrollService.scrollToSection(
                    ScrollService.quoteKey,
                    context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselPage(int pageIndex, bool isMobile) {
    final startIndex = pageIndex * 3;
    final endIndex = (startIndex + 3).clamp(0, _allImages.length);
    final pageImages = _allImages.sublist(startIndex, endIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: pageImages.map((imagePath) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildImageCard(imagePath, isMobile),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildImageCard(String imagePath, bool isMobile) {
    return GestureDetector(
      onTap: () => _showImageDialog(imagePath),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullGallery(bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: _allImages.length,
      itemBuilder: (context, index) {
        return _buildGridImage(_allImages[index], index + 1);
      },
    );
  }

  Widget _buildGridImage(String imagePath, int number) {
    return GestureDetector(
      onTap: () => _showImageDialog(imagePath),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: const TextStyle(
                          color: Palette.deepGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(32),
        child: Stack(
          children: [
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                  maxHeight: 800,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Palette.deepGreen,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}