import 'package:flutter/material.dart';
import 'package:import_website/modules/main/mobile_main_content.dart';
import '../../widgets/responsive_widget.dart';
import 'desktop_main_content.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: const MobileMainContent(),
      tablet: DesktopMainContent(),
      desktop: DesktopMainContent(),
    );
  }
}
