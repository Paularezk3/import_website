import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/modules/home/views/mobile_home_view.dart';
import 'package:import_website/modules/product_details/machine_details_page.dart';
import 'package:import_website/widgets/defaults/default_loading_widget.dart';
import '../../core/utils/translation/translation_service.dart';
import '../../routes/pages_names.dart';
import '../contact_us/views/mobile_contact_us_view.dart';
import '../home/controller/home_controller.dart';
import '../services/views/mobile_services_view.dart';
import 'controllers/main_home_controller.dart';
import 'mobile_appbar.dart';

class MobileMainContent extends StatefulWidget {
  final WebsiteView page;
  const MobileMainContent({required this.page, super.key});

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

  // Helper function to build the ListTile with hover and active state
  Widget _buildNavItem(BuildContext context,
      {required String title,
      required bool isActive,
      required VoidCallback onTap,
      isPage = true}) {
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
                    color: isPage
                        ? (isActive
                            ? activeColor // Active tile color
                            : (isHovered ? hoverColorText : defaultColor))
                        : hoverColorText, // Hover or default color
                  ),
                ),
                if (isPage) ...[
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 150), // Animation duration
                    height: 2,
                    width: isActive || isHovered
                        ? 30
                        : 0, // Animate width from 0 to 20
                    color:
                        isActive ? activeColor : hoverColorLine, // Line color
                  ),
                ]
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
    mainHomeController.switchWebsiteViewWithoutRebuild(widget.page);
    String currentLanguageCode =
        Get.locale?.languageCode ?? 'en'; // Default to 'en' if null
    return Scaffold(
      backgroundColor: AppColors.blackAndWhiteColor(context),
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MobileAppBar(
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
                    return MobileHomeView(myController: myController);
                  }
                } else if (mainHomeController.currentPage.value ==
                    WebsiteView.contactUs) {
                  return const MobileContactUsView();
                } else if (mainHomeController.currentPage.value ==
                    WebsiteView.services) {
                  return const MobileServicesView();
                } else if (mainHomeController.currentPage.value ==
                    WebsiteView.machineDetails) {
                  return const MachineDetailsPage();
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
                        title: 'home'.tr,
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.home,
                        onTap: () {
                          Get.toNamed(PagesNames.home);
                          _toggleDrawer();
                        },
                      ),
                      // Services ListTile
                      _buildNavItem(
                        context,
                        title: 'services'.tr,
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.services,
                        onTap: () {
                          Get.toNamed(PagesNames.services);
                          _toggleDrawer();
                        },
                      ),
                      // About ListTile
                      _buildNavItem(
                        context,
                        title: 'about'.tr,
                        isActive:
                            Get.find<MainHomeController>().currentPage.value ==
                                WebsiteView.about,
                        onTap: () {
                          Get.toNamed(PagesNames.aboutUs);
                          _toggleDrawer();
                        },
                      ),
                      // Contact ListTile
                      _buildNavItem(context,
                          title: 'contact_us'.tr,
                          isActive: Get.find<MainHomeController>()
                                  .currentPage
                                  .value ==
                              WebsiteView.contactUs, onTap: () {
                          Get.toNamed(PagesNames.contactUs);
                        _toggleDrawer();
                      }),
                      // Arabic ListTile
                      _buildNavItem(context,
                          title: currentLanguageCode == "en"
                              ? 'العربية-🇪🇬'
                              : 'ENGLISH-🇱🇷',
                          isActive: false, onTap: () {
                        currentLanguageCode == "en"
                            ? TranslationService.changeLanguage(
                                const Locale("ar", "EG"))
                            : TranslationService.changeLanguage(
                                const Locale("en", "US"));
                        _toggleDrawer();
                      }),
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
