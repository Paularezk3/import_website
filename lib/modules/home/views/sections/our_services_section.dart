import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/default_build_image.dart';
import '../../controller/home_controller.dart';

class OurServicesSection extends StatefulWidget {
  final bool isMobile;
  const OurServicesSection({required this.isMobile, super.key});

  @override
  _OurServicesSectionState createState() => _OurServicesSectionState();
}

class _OurServicesSectionState extends State<OurServicesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _imageAnimation;
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
      begin: const Offset(-1.5, 0), // Start offscreen to the left
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

    _imageAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
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
      key: const Key('our_services_section'),
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
        // Slide transition for the title
        SlideTransition(
          position: _titleSlideAnimation,
          child: Text(
            'Our Services'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColors.notBlackAndWhiteColor(context),
                ),
          ),
        ),
        const SizedBox(height: 8),
        // Fade transition for the description text
        FadeTransition(
          opacity: _textOpacityAnimation,
          child: Text(
            'Providing high-quality recycling machines and spare parts with a commitment to continuous improvement and reliability.'
                .tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // First image
        FadeTransition(
            opacity: _imageAnimation,
            child: buildImage('homepage_photo3.jpg', myController.photos)),
        const SizedBox(height: 16),
      ],
    );
  }

  Column laptop(BuildContext context) {
    return Column(
      children: [
        // Slide transition for the title
        SlideTransition(
          position: _titleSlideAnimation,
          child: Text(
            'Our Services'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColors.notBlackAndWhiteColor(context),
                ),
          ),
        ),
        const SizedBox(height: 8),
        // Fade transition for the description text
        FadeTransition(
          opacity: _textOpacityAnimation,
          child: Text(
            'Providing high-quality recycling machines and spare parts with a commitment to continuous improvement and reliability.'
                .tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  buildImage('homepage_photo3.jpg', myController.photos),
                  const SizedBox(width: 16),
                  Text(
                    'Machine importing'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Regularly importing diverse recycling machines and spare parts to ensure optimal performance and support.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  buildImage('homepage_photo4.jpg', myController.photos),
                  const SizedBox(height: 16),
                  Text(
                    'Quality Assurance'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Regularly importing diverse recycling machines and spare parts to ensure optimal performance and support.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
