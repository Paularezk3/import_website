import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/core/utils/translation/translation_service.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';
import 'package:import_website/widgets/default_build_image.dart';

import '../../../../widgets/defaults/default_loading_widget.dart';

class MachinesSection extends StatelessWidget {
  final bool isMobile;
  MachinesSection({required this.isMobile, super.key});

  final myController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (myController.isLoadingMachines.value) {
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
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate crossAxisCount dynamically based on screen size
                int crossAxisCount = isMobile
                    ? 2
                    : constraints.maxWidth > 700
                        ? (constraints.maxWidth > 1000 ? 4 : 3)
                        : 2;
                  
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable inner GridView scroll
                  itemCount: myController.machines.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        myController.goToMachineDetailsPage(myController.machines[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: HoverCard(
                          onPressed: () => myController.goToMachineDetailsPage(myController.machines[index]),
                          child: Column(
                            children: [
                              Expanded(
                                child: myController.isLoadingMachinesPhotos.value
                                        ? buildImage(
                                            myController
                                                .machines[index].photoName,
                                            [],
                                            filePath: myController
                                                .machines[index].photoPath)
                                        : buildImage(
                                            myController
                                                .machines[index].photoName,
                                            myController.machinesPhotos,
                                          ),
                              ),
                              const SizedBox(height: 15.0),
                              Obx(() {
                                return Text(
                                  TranslationService.currentLang.value == const Locale("ar", "EG")
                                      ? myController.machines[index].nameAr
                                      : myController.machines[index].nameEn,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: AppColors.notBlackAndWhiteColor(context),
                                      ),
                                );
                              }),
                              const SizedBox(height: 5.0),
                              Obx(() {
                                return Text(
                                  TranslationService.currentLang.value == const Locale("ar", "EG")
                                      ? myController.machines[index].descriptionAr
                                      : myController.machines[index].descriptionEn,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
                    backgroundColor: Colors.blue, // Set the background color here
                  ),
                  child: Text(
                    "View Details",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
