import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';

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
            Stack(
              children: [
                SizedBox(
                  height: 400, // Set your desired fixed height
                  width: double
                      .infinity, // Ensure the video takes the full width of the screen
                  child: FutureBuilder(
                    future: myController.initializeVideoPlayerFuture.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ClipRect(
                          child: FittedBox(
                            fit: BoxFit
                                .cover, // Ensure the video covers the full width and crops the height if necessary
                            child: SizedBox(
                              width: myController
                                  .videoPlayerController.value.value.size.width,
                              height: myController.videoPlayerController.value
                                  .value.size.height,
                              child: Chewie(controller:
                                  myController.chewieController.value),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading video'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Our Company',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blackAndWhiteLightMode),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Quality machines since 2008,\nzero returns, continuous improvement.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.blackAndWhiteLightMode),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // Handle contact button press
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.white), // Stroke color
                            ),
                            child: const Text(
                              'Contact',
                              style: TextStyle(
                                  color: Colors
                                      .white), // Text color same as stroke
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Handle learn more button press
                            },
                            child: const Text(
                              'Learn More',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              color: AppColors.backgroundSecondaryColor(context), // Set your desired background color here
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
