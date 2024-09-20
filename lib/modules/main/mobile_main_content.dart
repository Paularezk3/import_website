import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/modules/home/views/mobile_home_view.dart';
import 'package:import_website/widgets/defaults/default_loading_widget.dart';
import '../contact_us/views/mobile_contact_us_view.dart';
import '../home/controller/home_controller.dart';
import 'controllers/main_home_controller.dart';
import 'responsive_appbar.dart';

class MobileMainContent extends StatefulWidget {
  const MobileMainContent({super.key});

  @override
  State<MobileMainContent> createState() => _MobileMainContentState();
}

class _MobileMainContentState extends State<MobileMainContent>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late AnimationController _controller;
  late Animation<double> _drawerAnimation;
  final myController = Get.find<HomeController>();
  final mainHomeController = Get.find<MainHomeController>();
  late Animation<Offset> _slideAnimation;

  // Helper function to build the ListTile with hover and active state
  Widget _buildNavItem(BuildContext context,
      {required String title,
      required bool isActive,
      required VoidCallback onTap}) {
    Color hoverColorText =
        AppColors.notBlackAndWhiteColor(context); // Color on hover
    Color hoverColorLine = Colors.grey[300]!; // Color on hover
    Color activeColor = Colors.blue; // Active color
    Color defaultColor = AppColors.notBlackAndWhiteColor(context);
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: ListTile(
            title: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive
                        ? activeColor // Active tile color
                        : (isHovered
                            ? hoverColorText
                            : defaultColor), // Hover or default color
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 150), // Animation duration
                  height: 2,
                  width: isActive || isHovered
                      ? 30
                      : 0, // Animate width from 0 to 20
                  color: isActive ? activeColor : hoverColorLine, // Line color
                ),
              ],
            ),
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        );
      },
    );
  }

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
              // Wrap the body with Obx to monitor the loading state
              Obx(() {
                if (Get.find<MainHomeController>().currentPage.value ==
                    WebsiteView.home) {
                  if (myController.isLoading.value) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                          height: 400,
                          child: Center(
                              child:
                                  DefaultLoadingWidget())), // Display loading widget
                    );
                  } else {
                    return MobileHomeView(
                        myController: myController,
                        slideAnimation: _slideAnimation);
                  }
                } else if (mainHomeController.currentPage.value ==
                    WebsiteView.contactUs) {
                  return const MobileContactUsView();
                } else if (mainHomeController.currentPage.value ==
                    WebsiteView.services) {
                  return Container();
                } else {
                  return Container();
                }
              }),
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
                      // Home ListTile
                      _buildNavItem(
                        context,
                        title: 'Home',
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.home,
                        onTap: () {
                          Get.find<MainHomeController>()
                              .switchWebsiteView(WebsiteView.home);
                          _toggleDrawer();
                        },
                      ),
                      // Services ListTile
                      _buildNavItem(
                        context,
                        title: 'Services',
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.services,
                        onTap: () {
                          Get.find<MainHomeController>()
                              .switchWebsiteView(WebsiteView.services);
                          _toggleDrawer();
                        },
                      ),
                      // About ListTile
                      _buildNavItem(
                        context,
                        title: 'About',
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.about,
                        onTap: () {
                          Get.find<MainHomeController>()
                              .switchWebsiteView(WebsiteView.about);
                          _toggleDrawer();
                        },
                      ),
                      // Contact ListTile
                      _buildNavItem(
                        context,
                        title: 'Contact',
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.contactUs,
                        onTap: () {
                          Get.find<MainHomeController>()
                              .switchWebsiteView(WebsiteView.contactUs);
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
      )),
    );
  }
}
