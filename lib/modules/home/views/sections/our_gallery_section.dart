import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import '../../../../widgets/default_build_image.dart';

class OurGallerySection extends StatefulWidget {
  final bool isMobile;
  const OurGallerySection({required this.isMobile, super.key});

  @override
  _OurGallerySectionState createState() => _OurGallerySectionState();
}

class _OurGallerySectionState extends State<OurGallerySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final myController = Get.find<MainHomeController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
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
        Text(
          'Our Gallery',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.notBlackAndWhiteColor(context)
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore our diverse range of recycling machines and innovations.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.notBlackAndWhiteColor(
                    context), // Override only the color
              ),
        ),

        const SizedBox(height: 16),
        // First row of images
        Row(
          children: [
            Expanded(
                child: buildImage('homepage_photo5.jpg', myController.photos, height: 300)),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: buildImage('homepage_photo6.jpg', myController.photos, height: 300)),
          ],
        ),
        const SizedBox(height: 16),
        // Second row of images
        Row(
          children: [
            Expanded(
                child: buildImage('homepage_photo7.jpg', myController.photos, height: 300)),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: buildImage('homepage_photo8.jpg', myController.photos, height: 300)),
          ],
        ),
      ],
    );
  }

  Column laptop(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Our Gallery',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.notBlackAndWhiteColor(context)
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore our diverse range of recycling machines and innovations.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
        ),
        const SizedBox(height: 16),
        // First row of images
        Row(
          children: [
            Expanded(
                child: buildImage('homepage_photo5.jpg', myController.photos, height: 300)),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: buildImage('homepage_photo6.jpg', myController.photos, height: 300)),
          ],
        ),
        const SizedBox(height: 16),
        // Second row of images
        Row(
          children: [
            Expanded(
                child: buildImage('homepage_photo7.jpg', myController.photos, height: 300)),
            const SizedBox(width: 8), // Space between images
            Expanded(
                child: buildImage('homepage_photo8.jpg', myController.photos, height: 300)),
          ],
        ),
      ],
    );
  }
}
