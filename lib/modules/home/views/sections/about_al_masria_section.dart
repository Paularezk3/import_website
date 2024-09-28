import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
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
  late Animation<Offset> _animation;
  final myController = Get.find<HomeController>();

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Al Masria'.tr,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.notBlackAndWhiteColor(context),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Leading importer of recycling machines in Egypt since 2008, committed to quality and continuous improvement.'.tr,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        // First image
        buildImage('homepage_photo1.jpg', myController.photos),
        const SizedBox(height: 16),
        // Second image with smaller height and rounded corners
        buildImage('homepage_photo2.jpg', myController.photos),
      ],
    );
  }

  Row laptop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text content in a Flexible widget
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'About Al Masria'.tr,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.notBlackAndWhiteColor(context)
          ),
                // style: GoogleFonts.openSans(
                //   textStyle: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.notBlackAndWhiteColor(context),
                //   ),
                // ),
              ),
              const SizedBox(height: 16),
              Text(
                'Leading importer of recycling machines in Egypt since 2008, committed to quality and continuous improvement.'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        // Spacer to add space between text and images
        
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width > 900? 50:0,
        ),
        // First image
        Flexible(
          flex: 3,
          child: buildImage('homepage_photo1.jpg', myController.photos,
              height: 300),
        ),
        // Second image with smaller height and rounded corners
        Flexible(
          flex: 3,
          child: buildImage('homepage_photo2.jpg', myController.photos,
              height: 300),
        ),
      ],
    );
  }
}
