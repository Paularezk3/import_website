import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/widgets/defaults/clickable_logo.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/translation/translation_service.dart';
import '../../routes/pages_names.dart';
import 'controllers/main_home_controller.dart';

// Widget version for use in Scaffold
class DesktopAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isDrawerOpen;
  final VoidCallback? onMenuPressed;

  const DesktopAppbar({
    super.key,
    this.isDrawerOpen,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final mainHomeController = Get.find<MainHomeController>();
    String currentLanguageCode =
        Get.locale?.languageCode ?? 'en'; // Default to 'en' if null

    Widget buildAppBarButton(BuildContext context,
        {required String title,
        required bool isActive,
        required VoidCallback onTap,
        bool isPage = true}) {
      Color hoverColorText = AppColors.notBlackAndWhiteColor(context);
      Color hoverColorLine = AppColors.notBlackAndWhiteColor(context);
      Color activeColor = Colors.blue;
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
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      color: isPage
                          ? (isActive
                              ? activeColor
                              : (isHovered ? hoverColorText : defaultColor))
                          : hoverColorText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Text(title),
                  ),
                  if (isPage) ...[
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: 2,
                      width: isActive || isHovered ? 30 : 0,
                      color: isActive ? activeColor : hoverColorLine,
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.blackAndWhiteColor(context),
      foregroundColor: AppColors.notBlackAndWhiteColor(context),
      elevation: 0.0,
      surfaceTintColor: AppColors.blackAndWhiteColor(context),
      shadowColor: AppColors.notBlackAndWhiteColor(context),
      title: ClickableLogo(),
      actions: [
        buildAppBarButton(
          context,
          title: 'home'.tr,
          isActive: mainHomeController.currentPage.value == WebsiteView.home,
          onTap: () {
            Get.toNamed(PagesNames.home);
          },
        ),
        buildAppBarButton(
          context,
          title: 'our_products'.tr,
          isActive: mainHomeController.currentPage.value == WebsiteView.ourProducts,
          onTap: () {
            Get.toNamed(PagesNames.ourProducts);
          },
        ),
        buildAppBarButton(
          context,
          title: 'services'.tr,
          isActive:
              mainHomeController.currentPage.value == WebsiteView.services,
          onTap: () {
            Get.toNamed(PagesNames.services);
          },
        ),
        buildAppBarButton(
          context,
          title: 'contact_us'.tr,
          isActive:
              mainHomeController.currentPage.value == WebsiteView.contactUs,
          onTap: () {
            Get.toNamed(PagesNames.contactUs);
          },
        ),
        buildAppBarButton(
          context,
          title: currentLanguageCode == "en" ? 'العربية-🇪🇬' : 'ENGLISH-🇱🇷',
          isActive: false,
          onTap: () {
            currentLanguageCode == "en"
                ? TranslationService.changeLanguage(const Locale("ar", "EG"))
                : TranslationService.changeLanguage(const Locale("en", "US"));
          },
          isPage: false,
        ),
      ],
    );
  }
}
