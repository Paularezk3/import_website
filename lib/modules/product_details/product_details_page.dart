import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/database_classes/product_details.dart';
import 'package:import_website/core/utils/app_breakpoints.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/modules/home/views/sections/page_tail_section.dart';
import 'package:import_website/modules/product_details/controller/product_details_controller.dart';
import 'package:import_website/modules/product_details/widgets/rich_text_widget.dart';
import 'package:import_website/widgets/default_build_image.dart';
import 'package:import_website/widgets/defaults/default_loading_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/database_classes/product_attributes_and_types.dart';
import '../../core/utils/translation/translation_service.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductType productType;
  final int? productId;
  final Machines? machine;
  final SpareParts? sparePart;
  const ProductDetailsPage(
      {required this.productType,
      super.key,
      this.productId,
      this.machine,
      this.sparePart});
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(
        productType: productType,
        productId: productId,
        machineValue: machine,
        sparePartValue: sparePart,
      ),
      dispose: (_) => Get.delete<ProductDetailsController>(),
      builder: (myController) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (myController.productType != productType ||
              myController.productId != productId ||
              myController.machine.value != machine ||
              myController.sparePart.value != sparePart) {
            myController.productType = productType;
            myController.productId = productId;
            myController.machine.value = machine;
            myController.sparePart.value = sparePart;
            myController.initialize();
          }
        });

        return Obx(() {
          if (myController.isLoading1.value) {
            return const ShimmerPage();
          } else {
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  TranslationService.currentLang.value ==
                          const Locale("ar", "EG")
                      ? myController.machine.value?.nameAr ??
                          myController.sparePart.value!.nameAr
                      : myController.machine.value?.nameEn ??
                          myController.sparePart.value!.nameEn,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.notBlackAndWhiteColor(context),
                      ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultRichTextWidget(
                    textFromDatabase: TranslationService.currentLang.value ==
                            const Locale("ar", "EG")
                        ? myController.machine.value?.descriptionAr ??
                            myController.sparePart.value!.descriptionAr
                        : myController.machine.value?.descriptionEn ??
                            myController.sparePart.value!.descriptionEn,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                ),
                const SizedBox(height: 40),

                Obx(() {
                  if (myController.isLoadingProductMediaQuery.value) {
                    return const DefaultLoadingWidget();
                  } else {
                    int _length = myController.machinesMediaQuery?.length ??
                        myController.sparePartsMediaQuery!.length;
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                      height: MediaQuery.of(context).size.width > 700
                          ? (MediaQuery.of(context).size.width > 850
                              ? 600
                              : 500)
                          : 400,
                      child: Column(
                        children: [
                          Expanded(
                              child: PageView.builder(
                            controller: _pageController,
                            itemCount:
                                myController.machinesMediaQuery?.length ??
                                    myController.sparePartsMediaQuery!.length,
                            itemBuilder: (context, index) {
                              if (myController
                                      .machinesMediaQuery?[index].isVideo ??
                                  myController
                                      .sparePartsMediaQuery![index].isVideo) {
                                // Map the current index to the correct video player controller using the videoIndices list
                                final int videoControllerIndex =
                                    myController.videoIndices.indexOf(index);

                                // Ensure we are in range
                                if (videoControllerIndex >= 0 &&
                                    videoControllerIndex <
                                        myController
                                            .videoPlayerControllers.length) {
                                  return Obx(
                                    () {
                                      if (myController
                                          .videoPlayerControllers[
                                              videoControllerIndex]
                                          .value
                                          .isInitialized) {
                                        return ClipRect(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: SizedBox(
                                              width: myController
                                                  .videoPlayerControllers[
                                                      videoControllerIndex]
                                                  .value
                                                  .size
                                                  .width,
                                              height: myController
                                                  .videoPlayerControllers[
                                                      videoControllerIndex]
                                                  .value
                                                  .size
                                                  .height,
                                              child: Chewie(
                                                controller: myController
                                                        .chewieControllers[
                                                    videoControllerIndex],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: Text(
                                            'Video failed to initialize',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      'Invalid video index',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                              } else {
                                // If it's an image, return the image widget
                                return buildImage(
                                    myController.machinesMediaQuery?[index]
                                            .photoName ??
                                        myController
                                            .sparePartsMediaQuery![index]
                                            .photoName,
                                    [],
                                    filePath: myController
                                            .machinesMediaQuery?[index]
                                            .photoPath ??
                                        myController
                                            .sparePartsMediaQuery![index]
                                            .photoPath,
                                    fit: BoxFit.contain);
                              }
                            },
                            onPageChanged: (index) {
                              // Handle page change if needed
                            },
                          )),
                          if (_length > 1) ...[
                            const SizedBox(
                                height: 16), // Spacing for the indicator
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: myController.machinesMediaQuery?.length ??
                                  myController.sparePartsMediaQuery!.length,
                              onDotClicked: (index) =>
                                  _pageController.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubic),
                              effect: const ExpandingDotsEffect(
                                activeDotColor: Colors.white,
                                dotColor: Colors.grey,
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 8,
                                expansionFactor: 4,
                              ),
                            )
                          ],
                          const SizedBox(
                              height: 16), // Padding below the indicator
                        ],
                      ),
                    );
                  }
                }),
                const SizedBox(height: 40),

                // Glassy styled table for attributes
                Obx(
                  () {
                    if (myController.isLoadingAttributes.value) {
                      return const DefaultLoadingWidget();
                    } else {
                      return Row(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Flexible(
                            flex: 5,
                            child: _buildGlassyAttributesTable(
                                myController, context),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
                if (myController.productType == ProductType.machine &&
                    myController.machineSpareParts.isNotEmpty) ...[
                  Obx(
                    () {
                      if (myController.isLoadingAttributes.value) {
                        return const DefaultLoadingWidget();
                      } else {
                        if (MediaQuery.of(context).size.width <
                            AppBreakpoints.mobileMaxWidth) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: _buildSparePartsTable(myController, context),
                          );
                        } else {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Flexible(
                                flex: 5,
                                child: _buildSparePartsTable(
                                    myController, context),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                ],
                PageTailSection(
                    isMobile: MediaQuery.of(context).size.width >
                            AppBreakpoints.mobileMaxWidth
                        ? false
                        : true)
              ],
            ));
          }
        });
      },
    );
  }

  Widget _buildGlassyAttributesTable(
      ProductDetailsController myController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.2), // Slightly darker color with opacity
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.notBlackAndWhiteColor(context)
                  .withOpacity(0.2), // Dark stroke effect
              width: 1,
            ),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(
              color: Colors.transparent,
            ),
            children: myController.attribute.map((attribute) {
              return TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface
                      .withOpacity(0.5), // Adjust for theme-based glassy effect
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      TranslationService.currentLang.value ==
                              const Locale("ar", "EG")
                          ? attribute.attributeNameAr!
                          : attribute.attributeNameEn!,
                      style: TextStyle(
                          color: AppColors.notBlackAndWhiteColor(context),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      TranslationService.currentLang.value ==
                              const Locale("ar", "EG")
                          ? attribute.attributeValueAr!
                          : attribute.attributeValueEn!,
                      style: TextStyle(
                          color: AppColors.notBlackAndWhiteColor(context),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSparePartsTable(
      ProductDetailsController myController, BuildContext context) {
    // Determine the number of columns based on the screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (screenWidth > 1200) {
      crossAxisCount = 4; // Four columns for large screens
    } else if (screenWidth > 900) {
      crossAxisCount = 3; // Three columns for medium screens
    } else if (screenWidth > AppBreakpoints.mobileMaxWidth) {
      crossAxisCount = 2; // Two columns for small screens
    } else {
      crossAxisCount = 2; // One column for very small screens
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Headline for the table
          Text(
            "Machine Spare Parts".tr,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.notBlackAndWhiteColor(context),
                ),
          ),
          const SizedBox(height: 16), // Space between headline and the table

          // Responsive GridView for spare parts
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.2), // Slightly darker color with opacity
                borderRadius: BorderRadius.circular(15),
              ),
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable internal scrolling
                shrinkWrap: true, // Allows GridView to wrap the content height
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Dynamic columns
                  crossAxisSpacing: 20, // Reduced spacing for better layout
                  mainAxisSpacing: 20, // Reduced spacing for better layout
                  childAspectRatio: 1, // Increased height relative to width
                ),
                itemCount: myController.machineSpareParts.length,
                itemBuilder: (context, index) {
                  final sparePart = myController.machineSpareParts[index];
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.5), // Glassy effect
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () =>
                          myController.goToSparePartDetailsPage(sparePart),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Spare part name
                          Text(
                            TranslationService.currentLang.value ==
                                    const Locale("ar", "EG")
                                ? sparePart.nameAr
                                : sparePart.nameEn,
                            style: TextStyle(
                              color: AppColors.notBlackAndWhiteColor(context),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Image of the spare part
                          Expanded(
                            child: buildImage(
                              sparePart.photoName,
                              [],
                              filePath: sparePart.photoPath,
                              height: 200, // Set a fixed height for the image
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Part type or additional details
                          Text(
                            TranslationService.currentLang.value ==
                                    const Locale("ar", "EG")
                                ? sparePart.typeAr
                                : sparePart.typeEn,
                            style: TextStyle(
                              color: AppColors.notBlackAndWhiteColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPage extends StatelessWidget {
  const ShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shimmer for the Title Box
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor(context),
            highlightColor: AppColors.shimmerHighlightColor(context),
            child: Container(
              width: 400,
              height: 40,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor(context),
                  highlightColor: AppColors.shimmerHighlightColor(context),
                  child: Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[300]),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),

          // Shimmer for the Image Box
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor(context),
            highlightColor: AppColors.shimmerHighlightColor(context),
            child: Container(
              width: MediaQuery.of(context).size.width - 70,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey[300]),
            ),
          ),
          const SizedBox(height: 40),

          // Shimmer for Description Rows
          Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor(context),
                  highlightColor: AppColors.shimmerHighlightColor(context),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
