import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
import 'package:import_website/modules/home/views/sections/starting_video.dart';

import '../../../core/utils/app_colors.dart';
import 'sections/about_al_masria_section.dart';
import 'sections/our_gallery_section.dart';
import 'sections/our_services_section.dart';
import 'sections/page_tail_section.dart';

class LaptopHomeView extends StatelessWidget {
  const LaptopHomeView({super.key, required this.myController});

  final HomeController myController;

  @override
  Widget build(BuildContext context) {
    myController.changeIsMobile(false);
    return GetBuilder<HomeController>(builder: (_) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            StartingVideo(myController: myController),
            const SizedBox(
              height: 20,
            ),
            const AboutAlMasriaSection(
              isMobile: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: AppColors.backgroundSecondaryColor(
                  context), // Set your desired background color here
              padding:
                  const EdgeInsets.all(16.0), // Optional: Add padding if needed
              child: const OurServicesSection(
                  isMobile: false), // Your section widget
            ),
            const OurGallerySection(
              isMobile: false,
            ),
            const PageTailSection(
              isMobile: false,
            ),
          ],
        ),
      );
    });
  }
}
