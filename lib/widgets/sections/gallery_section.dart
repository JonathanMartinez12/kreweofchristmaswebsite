import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/scroll_service.dart';
import '../layout/responsive_layout.dart';
import '../common/primary_button.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final galleryItems = [
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0820.jpeg',
        number: 1,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0821.jpeg',
        number: 2,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0822.jpeg',
        number: 3,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0823.jpeg',
        number: 4,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0824.jpeg',
        number: 5,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0825.jpeg',
        number: 6,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0826.jpeg',
        number: 7,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0827.jpeg',
        number: 8,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0828.jpeg',
        number: 9,
      ),
      _GalleryItem(
        imagePath: 'assets/images/gallery/IMG_0829.jpeg',
        number: 10,
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white, // Clean white background
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 80 : 120,
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
                      color: Palette.deepGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
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
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 60),
              
              // Clean Grid
              _GalleryGrid(items: galleryItems),
              
              const SizedBox(height: 60),
              
              // CTA Button
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
}

class _GalleryItem {
  final String imagePath;
  final int number;

  const _GalleryItem({
    required this.imagePath,
    required this.number,
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
        final spacing = isMobile ? 20.0 : 32.0;
        final childAspectRatio = 1.0; // Square images

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
          _showImageDialog(context);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered 
              ? (Matrix4.identity()..translate(0.0, -8.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Colors.black.withOpacity(0.15)
                    : Colors.black.withOpacity(0.08),
                blurRadius: _isHovered ? 24 : 12,
                offset: Offset(0, _isHovered ? 12 : 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.asset(
                  widget.item.imagePath,
                  fit: BoxFit.cover,
                ),
                
                // Number badge in top-left
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${widget.item.number}',
                        style: const TextStyle(
                          color: Palette.deepGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Subtle hover overlay
                if (_isHovered)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                    ),
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
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(32),
        child: Stack(
          children: [
            // Large image
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
                    widget.item.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            
            // Close button
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
            
            // Image number in bottom-left
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Text(
                  'Image ${widget.item.number}',
                  style: const TextStyle(
                    color: Palette.deepGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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