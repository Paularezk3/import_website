import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/core/utils/translation/translation_service.dart';
import 'package:import_website/modules/contact_us/views/desktop_contact_us_view.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
import 'package:import_website/modules/home/views/laptop_home_view.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../widgets/defaults/default_loading_widget.dart';
import '../services/views/desktop_services_view.dart';
import 'controllers/main_home_controller.dart';

class DesktopMainContent extends StatelessWidget {
  DesktopMainContent({super.key});

  final myController = Get.find<HomeController>();
  final mainHomeController = Get.find<MainHomeController>();

  // Helper function to create AppBar button with hover and active state
  Widget _buildAppBarButton(BuildContext context,
      {required String title,
      required bool isActive,
      required VoidCallback onTap,
      bool isPage = true}) {
    Color hoverColorText =
        AppColors.notBlackAndWhiteColor(context); // Hover text color
    Color hoverColorLine =
        AppColors.notBlackAndWhiteColor(context); // Hover underline color
    Color activeColor = Colors.blue; // Active color
    Color defaultColor = Colors.grey[400]!;
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                  Colors.transparent), // No default overlay
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration:
                      const Duration(milliseconds: 250), // Animation duration
                  style: TextStyle(
                    color: isPage
                        ? (isActive
                            ? activeColor // Active button color
                            : (isHovered ? hoverColorText : defaultColor))
                        : hoverColorText, // Hover or default color
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text(title),
                ),
                if (isPage) ...[
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 150), // Animation duration
                    height: 2,
                    width: isActive || isHovered
                        ? 30
                        : 0, // Animate width for underline
                    color:
                        isActive ? activeColor : hoverColorLine, // Line color
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentLanguageCode =
        Get.locale?.languageCode ?? 'en'; // Default to 'en' if null

    return GetBuilder<MainHomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: AppColors.blackAndWhiteColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.blackAndWhiteColor(context),
          foregroundColor: AppColors.notBlackAndWhiteColor(context),
          elevation: 0.0,
          forceMaterialTransparency: false,
          surfaceTintColor: AppColors.blackAndWhiteColor(context),
          shadowColor: AppColors.notBlackAndWhiteColor(context),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppConstants.mainCompanyLogo,
                height: 30,
                fit: BoxFit.contain,
              ),
              if (MediaQuery.of(context).size.width > 700) ...[
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  child: Row(
                    children: [
                      const SizedBox(width: 12.0),
                      Text(
                        AppConstants.companyShortName.tr,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppColors.notBlackAndWhiteColor(context)),
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
          actions: [
            _buildAppBarButton(
              context,
              title: 'home'.tr,
              isActive: mainHomeController.currentPage.value == WebsiteView.home
                  ? true
                  : false,
              onTap: () {
                // Handle Home button tap
                mainHomeController.switchWebsiteView(WebsiteView.home);
              },
            ),
            _buildAppBarButton(
              context,
              title: 'about'.tr,
              isActive:
                  mainHomeController.currentPage.value == WebsiteView.about
                      ? true
                      : false,
              onTap: () {
                // Handle About button tap
                mainHomeController.switchWebsiteView(WebsiteView.about);
              },
            ),
            _buildAppBarButton(
              context,
              title: 'services'.tr,
              isActive:
                  mainHomeController.currentPage.value == WebsiteView.services
                      ? true
                      : false,
              onTap: () {
                // Handle Contact button tap
                mainHomeController.switchWebsiteView(WebsiteView.services);
              },
            ),
            _buildAppBarButton(
              context,
              title: 'contact_us'.tr,
              isActive:
                  mainHomeController.currentPage.value == WebsiteView.contactUs
                      ? true
                      : false,
              onTap: () {
                mainHomeController.switchWebsiteView(WebsiteView.contactUs);
              },
            ),
            _buildAppBarButton(context,
                title: currentLanguageCode == "en"
                    ? 'العربية-🇪🇬'
                    : 'ENGLISH-🇱🇷',
                isActive: mainHomeController.currentPage.value ==
                        WebsiteView.contactUs
                    ? true
                    : false, onTap: () {
              currentLanguageCode == "en"
                  ? TranslationService.changeLanguage(const Locale("ar", "EG"))
                  : TranslationService.changeLanguage(const Locale("en", "US"));
            }, isPage: false),
          ],
        ),
        body: SafeArea(
            child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                Obx(() {
                  if (myController.isLoading.value) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                          height: 400,
                          child: Center(
                              child:
                                  DefaultLoadingWidget())), // Display loading widget
                    );
                  } else {
                    if (mainHomeController.currentPage.value ==
                        WebsiteView.home) {
                      return LaptopHomeView(myController: myController);
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.contactUs) {
                      // return const MobileContactUsView();
                      return const DesktopContactUsView();
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.services) {
                      return const DesktopServicesView();
                    } else {
                      return const SliverToBoxAdapter();
                    }
                  }
                }),
              ],
            ),
          ],
        )),
      );
    });
  }
}
