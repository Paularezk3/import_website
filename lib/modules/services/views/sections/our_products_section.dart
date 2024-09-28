import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/core/utils/translation/translation_service.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';
import 'package:import_website/widgets/default_build_image.dart';

import '../../../../widgets/defaults/default_loading_widget.dart';

class OurProductsSection extends StatelessWidget {
  final bool isMobile;
  OurProductsSection({required this.isMobile, super.key});

  final myController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (myController.isLoading1.value) {
        return const DefaultLoadingWidget();
      } else {
        return Column(
          children: [
            Row(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
                  child: Text(
                    "Machines".tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppColors.notBlackAndWhiteColor(context),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 600,
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: isMobile ? 300 : 600,
                  child: GridView.builder(
                    itemCount: myController.machines.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile
                          ? 2
                          : MediaQuery.of(context).size.width > 700
                              ? (MediaQuery.of(context).size.width > 1000
                                  ? 4
                                  : 3)
                              : 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          myController.goToMachineDetailsPage(myController.machines[index].machineId);
                        },
                        child: HoverCard(
                          onPressed: () => myController.goToMachineDetailsPage(myController.machines[index].machineId),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: buildImage(
                                    myController.machines[index].photoPath,
                                    myController.machinesPhotos,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Obx(() {
                                return Text(
                                  TranslationService.currentLang.value ==
                                          const Locale("ar", "EG")
                                      ? myController
                                          .machines[index].machineNameAr
                                      : myController
                                          .machines[index].machineNameEn,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: AppColors.notBlackAndWhiteColor(
                                            context),
                                      ),
                                );
                              }),
                              const SizedBox(height: 5.0),
                              Obx(() {
                                return Text(
                                  TranslationService.currentLang.value ==
                                          const Locale("ar", "EG")
                                      ? myController
                                          .machines[index].descriptionAr
                                      : myController
                                          .machines[index].descriptionEn,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;
  const HoverCard({super.key, required this.child, required this.onPressed});

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isHovered ? 0.8 : 1.0,
            child: widget.child,
          ),
          if (_isHovered)
            Positioned.fill(
              child: Container(
                  color: Colors.black54.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Set the background color here
                    ),
                    child: Text(
                      "View Details",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}
