import 'package:flutter/material.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:import_website/modules/main/mobile_main_content.dart';
import '../../widgets/responsive_widget.dart';
import 'desktop_main_content.dart';

class MainHomeView extends StatelessWidget {
  final WebsiteView page;
  const MainHomeView({required this.page, super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileMainContent(page: page,),
      desktop: DesktopMainContent(page: page,),
    );
  }
}
