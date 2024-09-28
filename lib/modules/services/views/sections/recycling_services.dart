import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';

import '../../../../widgets/default_build_image.dart';

class RecyclingServices extends StatelessWidget {
  final bool isMobile;
  RecyclingServices({required this.isMobile, super.key});

  final myController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    var listOf3ServicesText = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
          Text(
            "Spare Parts Availability".tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          SizedBox(
            height: isMobile ? 15 : 20,
          ),
          Text(
            "Regular imports of spare parts support machine reliability and customer satisfaction."
                .tr
                .tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
          Text(
            "Quality Recycling Machines".tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          SizedBox(
            height: isMobile ? 15 : 20,
          ),
          Text(
            "We offer shredders, pelletizers, washing lines, and drying machines for various needs."
                .tr
                .tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
          Text(
            "Expert Engineering Support".tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          SizedBox(
            height: isMobile ? 15 : 20,
          ),
          Text(
            "Our founder, Rezk Ayoub, ensures continuous improvement and innovation in our machines."
                .tr
                .tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
        ],
      ),
    );

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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isMobile) ...[
                Flexible(
                  flex: 1,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: buildImage('services_photo1.jpg', myController.pagePhotos,
                        height: MediaQuery.of(context).size.width < 700? 500 : 300),
                  ),
                ),
                const SizedBox(width: 20),
              ],
              Flexible(
                flex: 1,
                child: listOf3ServicesText,
              )
            ],
          ),
          if (isMobile) ...[
            const SizedBox(width: 10),
            buildImage('services_photo1.jpg', myController.pagePhotos,
                height: 200),
          ],
        ],
      ),
    );
  }
}
