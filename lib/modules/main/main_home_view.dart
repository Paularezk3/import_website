import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/home/views/laptop_home_view.dart';
import 'package:import_website/modules/home/views/mobile_home_view.dart';
import '../contact_us/views/desktop_contact_us_view.dart';
import '../contact_us/views/mobile_contact_us_view.dart';
import '../services/views/desktop_services_view.dart';
import '../services/views/mobile_services_view.dart';
import 'custom_appbars.dart';
import 'desktop_main_content.dart';
import 'mobile_main_content.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a fixed AppBar here, content will change in the body
      appBar: _buildAppBar(context),
      body: Navigator(
        key: Get.nestedKey(1), // Use a nested navigator key
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          // Define the routes for desktop and mobile views
          WidgetBuilder builder;
          if (GetPlatform.isDesktop || GetPlatform.isMobile) {
            builder = _getDesktopRoute(settings.name);
          } else {
            builder = _getMobileRoute(settings.name);
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  WidgetBuilder _getDesktopRoute(String? route) {
    switch (route) {
      case '/home':
        return (context) => LaptopHomeView();
      case '/services':
        return (context) => const DesktopServicesView();
      case '/contact_us':
        return (context) => const DesktopContactUsView();
      default:
        return (context) => DesktopMainContent();
    }
  }

  WidgetBuilder _getMobileRoute(String? route) {
    switch (route) {
      case '/home':
        return (context) => MobileHomeView();
      case '/services':
        return (context) => const MobileServicesView();
      case '/contact_us':
        return (context) => const MobileContactUsView();
      default:
        return (context) => MobileMainContent();
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return GetPlatform.isDesktop || GetPlatform.isMobile
        ? DesktopAppBar() // Custom AppBar for desktop
        : MobileAppBar(); // Custom AppBar for mobile
  }
}
