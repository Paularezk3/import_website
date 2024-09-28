import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:import_website/modules/home/views/sections/page_tail_section.dart';

import 'sections/our_products_section.dart';
import 'sections/recycling_services.dart';

class DesktopServicesView extends StatelessWidget {
  const DesktopServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            RecyclingServices(isMobile: false,),
            const SizedBox(height: 40,),
            OurProductsSection(isMobile: false),
            const SizedBox(height: 30,),
            const PageTailSection(isMobile: false)
          ],
        ),
      );
    });
  }
}
