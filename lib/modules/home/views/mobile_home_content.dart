import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/core/utils/app_constants.dart';
import 'package:import_website/modules/home/views/mobile/about_al_masria_section.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile/our_services_section.dart';
import 'responsive_appbar.dart';

class MobileHomeContent extends StatefulWidget {
  const MobileHomeContent({super.key});

  @override
  State<MobileHomeContent> createState() => _MobileHomeContentState();
}

class _MobileHomeContentState extends State<MobileHomeContent>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late AnimationController _controller;
  late Animation<double> _drawerAnimation;
  late Animation<Offset> _slideAnimation;
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Animation controller for drawer
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _drawerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Slide animation for text
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Video player controller initialization with network video
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(AppConstants.homePageMainVideoUrl),
    );

    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    }).catchError((error) {
      // Handle any errors during video initialization
      print('Error initializing video: $error');
    });

    // Set looping and auto-play after initialization
    _initializeVideoPlayerFuture.then((_) {
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackAndWhiteColor(context),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ResponsiveAppBar(
                    isDrawerOpen: isDrawerOpen,
                    onMenuPressed: _toggleDrawer,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController.value.isInitialized
                            ? _videoPlayerController.value.aspectRatio
                            : 16 /
                                9, // Default aspect ratio before initialization
                        child: FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return VideoPlayer(_videoPlayerController);
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading video'));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlideTransition(
                              position: _slideAnimation,
                              child: Text(
                                'Welcome to Our Company',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackAndWhiteColor(
                                          context)),
                                ),
                                // style: TextStyle(
                                //   color: Colors.white,
                                //   fontSize: 24,
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ),
                            ),
                            const SizedBox(height: 30),
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
                            const SizedBox(height: 8),
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
                      ),
                    ],
                  ),
                ),
                // const SliverFillRemaining(
                //   // hasScrollBody: true,
                //   child: Center(
                //     child: Text('Additional Content Below'),
                //   ),
                // ),
                const SliverToBoxAdapter(
                  child: AboutAlMasriaSection(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors
                        .blue[50], // Set your desired background color here
                    padding: const EdgeInsets.all(
                        16.0), // Optional: Add padding if needed
                    child: const OurServicesSection(), // Your section widget
                  ),
                ),
              ],
            ),
            Positioned(
              top: kToolbarHeight,
              left: 0,
              right: 0,
              child: SizeTransition(
                sizeFactor: _drawerAnimation,
                axisAlignment: -1.0,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    color: AppColors.blackAndWhiteColor(context),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Home',
                            style: TextStyle(
                                color:
                                    AppColors.notBlackAndWhiteColor(context)),
                          ),
                          onTap: () {
                            _toggleDrawer();
                          },
                        ),
                        ListTile(
                          title: const Text('Services'),
                          onTap: () {
                            _toggleDrawer();
                          },
                        ),
                        ListTile(
                          title: const Text('About'),
                          onTap: () {
                            _toggleDrawer();
                          },
                        ),
                        ListTile(
                          title: const Text('Contact'),
                          onTap: () {
                            _toggleDrawer();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
