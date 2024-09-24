import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:import_website/modules/home/views/sections/page_tail_section.dart';

import 'sections/recycling_services.dart';

class MobileServicesView extends StatelessWidget {
  const MobileServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (_) {
      return const SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 30,),
            RecyclingServices(isMobile: true,),
            SizedBox(height: 30,),
            // OurLocationSection(isMobile: true,),
            SizedBox(height: 30,),
            PageTailSection(isMobile: true)
          ],
        ),
      );
    });
  }
}
