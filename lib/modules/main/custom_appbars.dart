import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_constants.dart';

class DesktopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(AppConstants.mainCompanyLogo, height: 30),
          const SizedBox(width: 12),
          const Text('Company Name'),
        ],
      ),
      actions: [
        _buildAppBarButton('home'.tr, '/home'),
        _buildAppBarButton('services'.tr, '/services'),
        _buildAppBarButton('contact_us'.tr, '/contact_us'),
      ],
    );
  }

  Widget _buildAppBarButton(String title, String route) {
    return TextButton(
      onPressed: () => Get.toNamed(route, id: 1), // Use the nested navigator
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mobile View'),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Get.toNamed('/menu', id: 1),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}
