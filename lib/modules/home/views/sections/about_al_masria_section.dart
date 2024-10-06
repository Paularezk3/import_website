import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/default_build_image.dart';

class AboutAlMasriaSection extends StatefulWidget {
  final bool isMobile;
  const AboutAlMasriaSection({required this.isMobile, super.key});

  @override
  _AboutAlMasriaSectionState createState() => _AboutAlMasriaSectionState();
}

class _AboutAlMasriaSectionState extends State<AboutAlMasriaSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _imageAnimation;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _titleAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _textAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _imageAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      _isVisible = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about_al_masria_section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.isMobile ? mobile(context) : laptop(context),
      ),
    );
  }

  Column mobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: _titleAnimation,
          child: Text(
            'About Al Masria'.tr,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.notBlackAndWhiteColor(context),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeTransition(
          opacity: _textAnimation,
          child: Text(
            'Leading importer of recycling machines in Egypt since 2008, committed to quality and continuous improvement.'.tr,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // First image
        ScaleTransition(
          scale: _imageAnimation,
          child: buildImage('homepage_photo1.jpg', []),
        ),
        const SizedBox(height: 16),
        // Second image with smaller height and rounded corners
        ScaleTransition(
          scale: _imageAnimation,
          child: buildImage('homepage_photo2.jpg', []),
        ),
      ],
    );
  }

  Row laptop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideTransition(
                position: _titleAnimation,
                child: Text(
                  'About Al Masria'.tr,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppColors.notBlackAndWhiteColor(context)),
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _textAnimation,
                child: Text(
                  'Leading importer of recycling machines in Egypt since 2008, committed to quality and continuous improvement.'.tr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 50),
        Flexible(
          flex: 3,
          child: ScaleTransition(
            scale: _imageAnimation,
            child: buildImage('homepage_photo1.jpg', []),
          ),
        ),
        Flexible(
          flex: 3,
          child: ScaleTransition(
            scale: _imageAnimation,
            child: buildImage('homepage_photo2.jpg', []),
          ),
        ),
      ],
    );
  }
}
