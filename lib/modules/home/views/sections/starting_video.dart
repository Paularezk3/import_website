import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';

import '../../../../core/utils/app_colors.dart';

class StartingVideo extends StatelessWidget {
  final HomeController myController;
  const StartingVideo({required this.myController, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                              child: Chewie(
                                  controller:
                                      myController.chewieController.value),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading video'.tr));
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
                        'Welcome to Our Company'.tr,
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
                        'Quality machines since 2008,\nzero returns, continuous improvement.'
                            .tr,
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
                              myController.goToContactUsPage();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.white), // Stroke color
                            ),
                            child: Text(
                              'contact_us'.tr,
                              style: const TextStyle(
                                  color: Colors
                                      .white), // Text color same as stroke
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Handle learn more button press
                              myController.goToOurProductsPage();
                            },
                            child: Text(
                              'Learn More'.tr,
                              style: const TextStyle(
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
            );
  }
}