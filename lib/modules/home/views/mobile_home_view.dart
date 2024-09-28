import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../controller/home_controller.dart';
import 'sections/about_al_masria_section.dart';
import 'sections/our_gallery_section.dart';
import 'sections/our_services_section.dart';
import 'sections/page_tail_section.dart';
import 'sections/starting_video.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({
    super.key,
    required this.myController,
  });

  final HomeController myController;

  @override
  Widget build(BuildContext context) {
    myController.changeIsMobile(true);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          StartingVideo(myController: myController),
          const AboutAlMasriaSection(
            isMobile: true,
          ),
          Container(
            color: AppColors.backgroundSecondaryColor(
                context), // Set your desired background color here
            padding:
                const EdgeInsets.all(16.0), // Optional: Add padding if needed
            child: const OurServicesSection(
              isMobile: true,
            ), // Your section widget
          ),
          const OurGallerySection(
            isMobile: true,
          ),
          const PageTailSection(
            isMobile: true,
          ),
        ],
      ),
    );
  }
}
