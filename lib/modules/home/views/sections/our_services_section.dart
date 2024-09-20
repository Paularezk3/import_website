import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/default_build_image.dart';

class OurServicesSection extends StatefulWidget {
  final bool isMobile;
  const OurServicesSection({required this.isMobile, super.key});

  @override
  _OurServicesSectionState createState() => _OurServicesSectionState();
}

class _OurServicesSectionState extends State<OurServicesSection>
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
        Text(
          'Our Services',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.notBlackAndWhiteColor(context)
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Providing high-quality recycling machines and spare parts with a commitment to continuous improvement and reliability.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        // First image
        buildImage('homepage_photo3.jpg', myController.photos),
        const SizedBox(height: 16),
        Text(
          'Machine importing',
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.notBlackAndWhiteColor(context),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Regularly importing diverse recycling machines and spare parts to ensure optimal performance and support.',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        // Second image with smaller height and rounded corners
        buildImage('homepage_photo4.jpg', myController.photos),
        const SizedBox(height: 16),
      ],
    );
  }

  Column laptop(BuildContext context) {
    return Column(
      children: [
        Text(
          'Our Services',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.notBlackAndWhiteColor(context)
          ),
          // style: GoogleFonts.openSans(
          //   textStyle: TextStyle(
          //     fontSize: 30,
          //     fontWeight: FontWeight.w800,
          //     color: AppColors.notBlackAndWhiteColor(context),
          //   ),
          // ),
        ),
        const SizedBox(height: 8),
        Text(
            'Providing high-quality recycling machines and spare parts with a commitment to continuous improvement and reliability.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        // First image
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  buildImage('homepage_photo3.jpg', myController.photos),
                  const SizedBox(width: 16),
                  Text('Machine importing',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Regularly importing diverse recycling machines and spare parts to ensure optimal performance and support.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
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
                  Text('Quality Assurance',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Regularly importing diverse recycling machines and spare parts to ensure optimal performance and support.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
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
