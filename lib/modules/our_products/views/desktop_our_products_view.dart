import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';

import '../../home/views/sections/page_tail_section.dart';
import '../../services/views/sections/machines_section.dart';
import '../../services/views/sections/spare_parts_section.dart';
import 'sections/recycling_services.dart';

class DesktopOurProductsView extends StatelessWidget {
  const DesktopOurProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(builder: (_) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            RecyclingServices(isMobile: false,),
            const SizedBox(height: 40,),
            MachinesSection(isMobile: false),
            const SizedBox(height: 40,),
            SparePartsSection(isMobile: false),
            const SizedBox(height: 30,),
            const PageTailSection(isMobile: false)
          ],
        ),
      );
    });
  }
}