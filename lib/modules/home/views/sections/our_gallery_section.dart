import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../widgets/default_build_image.dart';
import '../../controller/home_controller.dart';

class OurGallerySection extends StatefulWidget {
  final bool isMobile;
  const OurGallerySection({required this.isMobile, super.key});

  @override
  _OurGallerySectionState createState() => _OurGallerySectionState();
}

class _OurGallerySectionState extends State<OurGallerySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _imageAnimation1;
  late Animation<Offset> _imageAnimation2;
  late Animation<Offset> _imageAnimation3;
  late Animation<Offset> _imageAnimation4;
  final myController = Get.find<HomeController>();

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Animation controller for both slide and opacity animations
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Title slide animation from left to right
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0), // Start offscreen to the left
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    // Text opacity animation from 0% to 100%
    _textOpacityAnimation = Tween<double>(
      begin: 0.0, // Start fully transparent
      end: 1.0, // End fully opaque
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    double x = 1;
    double y = 0.5;
    _imageAnimation1 = Tween<Offset>(
      begin: Offset(-x, -y), // Start offscreen to the left
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    _imageAnimation2 = Tween<Offset>(
      begin: Offset(x, -y), // Start offscreen to the left
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    _imageAnimation3 = Tween<Offset>(
      begin: Offset(-x, y), // Start offscreen to the left
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    _imageAnimation4 = Tween<Offset>(
      begin: Offset(x, y), // Start offscreen to the left
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  // Trigger animation when the section becomes visible on the screen
  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      _isVisible = true;
      _controller.forward(); // Only start the animation when visible
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('our_gallery_section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.isMobile ? mobile(context) : laptop(context),
      ),
    );
  }

  Column mobile(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SlideTransition(
          position: _titleSlideAnimation,
          child: Text(
            'Our Gallery'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: AppColors.notBlackAndWhiteColor(context)
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeTransition(
          opacity: _textOpacityAnimation,
          child: Text(
            'Explore our diverse range of recycling machines and innovations.'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.notBlackAndWhiteColor(
                      context), // Override only the color
                ),
          ),
        ),

        const SizedBox(height: 16),
        // First row of images
        Row(
          children: [
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation1,
                  child: buildImage('homepage_photo5.jpg', myController.photos, height: 300))),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation2,
                  child: buildImage('homepage_photo6.jpg', myController.photos, height: 300))),
          ],
        ),
        const SizedBox(height: 16),
        // Second row of images
        Row(
          children: [
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation3,
                  child: buildImage('homepage_photo7.jpg', myController.photos, height: 300))),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation4,
                  child: buildImage('homepage_photo8.jpg', myController.photos, height: 300))),
          ],
        ),
      ],
    );
  }

  Column laptop(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SlideTransition(
          position: _titleSlideAnimation,
          child: Text(
            'Our Gallery'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: AppColors.notBlackAndWhiteColor(context)
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeTransition(
          opacity: _textOpacityAnimation,
          child: Text(
            'Explore our diverse range of recycling machines and innovations.'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
          ),
        ),
        const SizedBox(height: 16),
        // First row of images
        Row(
          children: [
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation1,
                  child: buildImage('homepage_photo5.jpg', myController.photos, height: 300))),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation2,
                  child: buildImage('homepage_photo6.jpg', myController.photos, height: 300))),
          ],
        ),
        const SizedBox(height: 16),
        // Second row of images
        Row(
          children: [
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation3,
                  child: buildImage('homepage_photo7.jpg', myController.photos, height: 300))),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: SlideTransition(
                  position: _imageAnimation4,
                  child: buildImage('homepage_photo8.jpg', myController.photos, height: 300))),
          ],
        ),
      ],
    );
  }
}
