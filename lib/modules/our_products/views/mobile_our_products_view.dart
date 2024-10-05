import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:import_website/modules/home/views/sections/page_tail_section.dart';
import 'package:import_website/modules/services/views/sections/spare_parts_section.dart';

import '../../services/views/sections/machines_section.dart';
import 'sections/recycling_services.dart';

class MobileOurProductsView extends StatelessWidget {
  const MobileOurProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (_) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            RecyclingServices(isMobile: true,),
            const SizedBox(height: 30,),
            MachinesSection(isMobile: true,),
            const SizedBox(height: 30,),
            SparePartsSection(isMobile: true,),
            const SizedBox(height: 30,),
            const PageTailSection(isMobile: true),
          ],
        ),
      );
    });
  }
}
