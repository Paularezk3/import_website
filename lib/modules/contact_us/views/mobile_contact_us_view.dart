import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:import_website/modules/home/views/sections/page_tail_section.dart';
import 'sections/contact_el_masrya_section.dart';
import 'sections/our_location_section.dart';

class MobileContactUsView extends StatelessWidget {
  const MobileContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (myController) {
      myController.collectAndSendData();
      return const SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ContactElMasryaSection(
              isMobile: true,
            ),
            SizedBox(
              height: 30,
            ),
            OurLocationSection(
              isMobile: true,
            ),
            SizedBox(
              height: 30,
            ),
            PageTailSection(isMobile: true)
          ],
        ),
      );
    });
  }
}
