import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/contact_us/views/desktop_contact_us_view.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
import 'package:import_website/modules/home/views/laptop_home_view.dart';
import 'package:import_website/modules/main/desktop_appbar.dart';
import 'package:import_website/modules/our_products/views/desktop_our_products_view.dart';
import 'package:import_website/modules/product_details/machine_details_page.dart';
import 'package:import_website/modules/product_details/spare_parts_details_page.dart';

import '../../core/utils/app_colors.dart';
import '../../widgets/defaults/default_loading_widget.dart';
import '../services/views/desktop_services_view.dart';
import 'controllers/main_home_controller.dart';

class DesktopMainContent extends StatelessWidget {
  final WebsiteView page;
  DesktopMainContent({required this.page, super.key});

  final myController = Get.find<HomeController>();
  final mainHomeController = Get.find<MainHomeController>();

  // Helper function to create AppBar button with hover and active state

  @override
  Widget build(BuildContext context) {
    mainHomeController.switchWebsiteViewWithoutRebuild(page);

    return GetBuilder<MainHomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: AppColors.blackAndWhiteColor(context),
        appBar: const DesktopAppbar(),
        body: SafeArea(
            child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                Obx(() {
                  if (myController.isLoading.value) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                          height: 400,
                          child: Center(
                              child:
                                  DefaultLoadingWidget())), // Display loading widget
                    );
                  } else {
                    if (mainHomeController.currentPage.value ==
                        WebsiteView.home) {
                      return LaptopHomeView(myController: myController);
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.contactUs) {
                      // return const MobileContactUsView();
                      return const DesktopContactUsView();
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.services) {
                      return const DesktopServicesView();
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.machineDetails) {
                      return const MachineDetailsPage();
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.sparePartDetails) {
                      return const SparePartsDetailsPage();
                    } else if (mainHomeController.currentPage.value ==
                        WebsiteView.ourProducts) {
                      return const DesktopOurProductsView();
                    } else {
                      return const SliverToBoxAdapter();
                    }
                  }
                }),
              ],
            ),
          ],
        )),
      );
    });
  }
}
