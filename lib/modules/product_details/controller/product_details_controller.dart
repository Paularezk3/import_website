import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_website/core/database_classes/machines_media.dart';
import 'package:import_website/core/database_classes/product_attributes_and_types.dart';
import 'package:import_website/core/database_classes/spare_parts_media.dart';
import 'package:import_website/core/services/get_data.dart';
import 'package:import_website/modules/product_details/widgets/custom_chewie_controls.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../core/database_classes/product_details.dart';
import '../../../core/services/api_urls.dart';
import 'package:chewie/chewie.dart';

import '../../../core/services/debugging_test.dart';

class ProductDetailsController extends GetxController {
  RxBool isLoading1 = true.obs;
  RxBool isLoadingAttributes = true.obs;
  RxBool isLoadingMachineSpareParts = true.obs;
  final servicesController = Get.find<ServicesController>();
  final getDataController = Get.find<GetData>();

  // late RxList<VideoPlayerController> videoPlayerController;
  // late RxList<Future<void>> initializeVideoPlayerFuture;
  // late RxList<ChewieController> chewieController;
  // List<int> retryCount = [];

  Rxn<Machines> machine = Rxn<Machines>();
  Rxn<SpareParts> sparePart = Rxn<SpareParts>();
  RxList<SpareParts> machineSpareParts = RxList<SpareParts>();
  RxList<ProductAttributesAndTypes> attribute =
      RxList<ProductAttributesAndTypes>();

  ProductType productType;
  int? productId;
  Machines? machineValue;
  SpareParts? sparePartValue;

  // Constructor to pass the necessary data when initializing the controller
  ProductDetailsController({
    required this.productType,
    this.productId,
    this.machineValue,
    this.sparePartValue,
  });

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  void initialize() {
    fetchData(productType,
        productId: productId,
        machineValue: machineValue,
        spareParts: sparePartValue);
    getAttributes(); // Fetch the attributes when the controller is initialized
    if (productType == ProductType.machine) {
      getMachineSpareParts();
      getAllMachinePhotos();
    } else {
      getAllSparePartPhotos();
    }
  }

  @override
  void dispose() {
    Get.delete<
        ProductDetailsController>(); // Delete the controller when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData(ProductType productType,
      {int? productId, Machines? machineValue, SpareParts? spareParts}) async {
    if (isLoading1.value == false) isLoading1.value = true;

    if (productType == ProductType.machine) {
      fetchMachine(machineValue: machineValue, productId: productId);
    } else {
      fetchsparePart(sparePartValue: spareParts, productId: productId);
    }

    isLoading1.value = false;
  }

  Future<void> fetchMachine({int? productId, Machines? machineValue}) async {
    if (machineValue != null) {
      machine = Rxn<Machines>(machineValue);
    } else {
      var tempMachines = getDataController.machines == RxList<Machines>()
          ? await getDataController.getMachines()
          : getDataController.machines;
      machine = Rxn<Machines>(
          tempMachines.firstWhere((value) => value.id == productId));
    }
  }

  Future<void> fetchsparePart(
      {SpareParts? sparePartValue, int? productId}) async {
    if (sparePartValue != null) {
      sparePart = Rxn<SpareParts>(sparePartValue);
    } else {
      var tempSpareParts = getDataController.spareParts == RxList<SpareParts>()
          ? await getDataController.getSpareParts()
          : getDataController.spareParts;
      sparePart = Rxn<SpareParts>(
          tempSpareParts.firstWhere((value) => value.id == productId));
    }
  }

  Future<void> getAttributes() async {
    if (isLoadingAttributes.value == false) isLoadingAttributes.value = true;

    var tempAttribute1 = await getDataController.getProductAttributesAndTypes();
    List<ProductAttributesAndTypes> tempAttribute2 = [];
    for (var attr in tempAttribute1) {
      if (attr.source == "attribute") {
        if (attr.entityType == productType) {
          if (attr.id == productId) {
            tempAttribute2.add(attr);
          }
        }
      }
    }
    attribute.value = tempAttribute2;

    isLoadingAttributes.value = false;
  }

  Future<void> getMachineSpareParts() async {
    if (isLoadingMachineSpareParts.value == false) {
      isLoadingMachineSpareParts.value = true;
    }

    machineSpareParts.value = await getDataController
        .getMachineSpareParts(productId ?? sparePartValue!.id);

    isLoadingMachineSpareParts.value = false;
  }

  void goToSparePartDetailsPage(SpareParts sparePart) {
    Get.delete<ProductDetailsController>();
    Get.toNamed("/spare_part/${sparePart.id}",
        arguments: {"spare_part": sparePart});
  }

  RxList<MachinesMedia>? machinesMediaQuery;
  RxList<SparePartsMedia>? sparePartsMediaQuery;
  RxBool isLoadingProductMediaQuery = true.obs;
  RxList<VideoPlayerController> videoPlayerControllers =
      <VideoPlayerController>[].obs;
  RxList<Future<void>> initializeVideoPlayerFutures = <Future<void>>[].obs;
  RxList<ChewieController> chewieControllers = <ChewieController>[].obs;
  RxList<int> retryCounts = <int>[].obs;
  RxString videoError = ''.obs;
  final int maxRetries = 3;

  RxList<int> videoIndices =
      RxList(); // This will hold the indices of video items

  Future<void> getAllMachinePhotos() async {
    if (isLoadingProductMediaQuery.value == false) {
      isLoadingProductMediaQuery.value = true;
    }

    machinesMediaQuery =
        (await getDataController.getMachinesMedia(productId ?? machineValue!.id)).obs;

    for (var media in machinesMediaQuery!) {
      if (media.isVideo) {
        retryCounts.add(0); // Add retry count for this video
        videoPlayerControllers.add(VideoPlayerController.networkUrl(
          Uri.parse("${ApiUrls.baseUrl}${media.photoPath}${media.photoName}"),
        ));

        // Initialize the video with retry logic
        await _initializeVideoWithRetry(
            videoPlayerControllers.last, retryCounts.length - 1);
      }
    }
    for (int i = 0; i < machinesMediaQuery!.length; i++) {
      if (machinesMediaQuery![i].isVideo) {
        videoIndices.add(i);
      }
    }
    isLoadingProductMediaQuery.value = false; // Loading complete
  }

  Future<void> getAllSparePartPhotos() async {
    if (isLoadingProductMediaQuery.value == false) {
      isLoadingProductMediaQuery.value = true;
    }

    sparePartsMediaQuery =
        (await getDataController.getSparePartMedia(productId ?? machineValue!.id)).obs;

    for (var media in sparePartsMediaQuery!) {
      if (media.isVideo) {
        retryCounts.add(0); // Add retry count for this video
        videoPlayerControllers.add(VideoPlayerController.networkUrl(
          Uri.parse("${ApiUrls.baseUrl}${media.photoPath}${media.photoName}"),
        ));

        // Initialize the video with retry logic
        await _initializeVideoWithRetry(
            videoPlayerControllers.last, retryCounts.length - 1);
      }
    }
    for (int i = 0; i < sparePartsMediaQuery!.length; i++) {
      if (sparePartsMediaQuery![i].isVideo) {
        videoIndices.add(i);
      }
    }
    isLoadingProductMediaQuery.value = false; // Loading complete
  }

  Future<void> _initializeVideoWithRetry(
    VideoPlayerController videoController,
    int retryIndex,
  ) async {
    int retryCount = retryCounts[retryIndex];

    while (retryCount < maxRetries) {
      try {
        // Attempt to initialize video player
        final futureInit = videoController.initialize();
        await futureInit;
        initializeVideoPlayerFutures.add(futureInit);

        if (videoController.value.isInitialized) {
          // Autoplay and loop the video
          videoController.setLooping(false);
          videoController.setVolume(0.3);

          // Initialize ChewieController for the video
          final chewieController = ChewieController(
            videoPlayerController: videoController,
            autoPlay: false,
            looping: true,
            allowFullScreen: true,
            allowMuting: true,
            draggableProgressBar: true,
            showControls: true,
            showControlsOnInitialize: true,
            controlsSafeAreaMinimum: const EdgeInsets.all(12),
            showOptions: true,
            autoInitialize: false,
            customControls:
                CustomChewieControls(), // Use the custom controls
            aspectRatio: videoController.value.aspectRatio,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );

          chewieControllers.add(chewieController);

          retryCounts[retryIndex] = retryCount; // Update retry count
          return; // Exit on success
        } else {
          throw Exception("Video controller not initialized");
        }
      } catch (error) {
        retryCount++;
        retryCounts[retryIndex] = retryCount; // Update retry count
        DebuggingTest.printSomething(error.toString());
        DebuggingTest.printSomething(
            'Attempt $retryCount failed for video $retryIndex. Retrying...');

        // Stop retrying after max retries
        if (retryCount >= maxRetries) {
          videoError.value =
              'Failed to load video $retryIndex after several attempts.';
          break;
        }

        // Wait before retrying
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  void onClose() {
    // Dispose all video controllers and Chewie controllers to prevent memory leaks
    for (var controller in videoPlayerControllers) {
      controller.dispose();
    }
    for (var chewieController in chewieControllers) {
      chewieController.dispose();
    }
    super.onClose();
  }
}
