import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';


class RecyclingServices extends StatelessWidget {
  final bool isMobile;
  RecyclingServices({required this.isMobile, super.key});

  final myController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
          Text(
            "Recycling Services Overview".tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          SizedBox(
            height: isMobile ? 15 : 20,
          ),
          Text(
            "Al Masria imports diverse recycling machines, ensuring quality and reliability for our clients."
                .tr
                .tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
        ],
      ),
    );
  }
}
