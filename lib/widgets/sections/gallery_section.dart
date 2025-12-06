import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    // Replace these with your actual image paths
    final galleryItems = [
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Elegant Roofline Display',
        category: 'Residential',
      ),
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Full Property Lighting',
        category: 'Residential',
      ),
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Commercial Storefront',
        category: 'Commercial',
      ),
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Tree & Landscape Lights',
        category: 'Residential',
      ),
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Custom Pattern Design',
        category: 'Residential',
      ),
      _GalleryItem(
        imagePath: 'assets/images/hero_house.jpg',
        title: 'Office Building Display',
        category: 'Commercial',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Palette.deepGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Text(
                'Our Work',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                    ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'See how we\'ve transformed homes and businesses across the city with our professional Christmas light installations.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 56),
              // Gallery Grid
              _GalleryGrid(items: galleryItems),
              const SizedBox(height: 56),
              // CTA
              PrimaryButton(
                label: 'View Full Gallery',
                isOutlined: true,
                onPressed: () {
                  // TODO: navigate to full gallery page or open lightbox
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryItem {
  final String imagePath;
  final String title;
  final String category;

  const _GalleryItem({
    required this.imagePath,
    required this.title,
    required this.category,
  });
}

class _GalleryGrid extends StatelessWidget {
  final List<_GalleryItem> items;

  const _GalleryGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
        
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
        final spacing = isMobile ? 16.0 : 24.0;
        final childAspectRatio = isMobile ? 1.2 : 1.3;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _GalleryCard(item: items[index]);
          },
        );
      },
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final _GalleryItem item;

  const _GalleryCard({required this.item});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Open image in lightbox/fullscreen
          _showImageDialog(context);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Palette.accentGold.withOpacity(0.4)
                    : Colors.black.withOpacity(0.3),
                blurRadius: _isHovered ? 24 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.asset(
                  widget.item.imagePath,
                  fit: BoxFit.cover,
                ),
                // Gradient overlay
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(_isHovered ? 0.7 : 0.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // Content overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(_isHovered ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.accentRed.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.item.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Title
                        Text(
                          widget.item.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: _isHovered ? 22 : 20,
                              ),
                        ),
                        // Expand icon when hovered
                        if (_isHovered) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(
                                Icons.zoom_in,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Click to view',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Hover zoom effect
                AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: _isHovered ? 1.05 : 1.0,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            // Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.item.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            // Info overlay
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.category,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}