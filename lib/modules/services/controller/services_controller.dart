import 'package:get/get.dart';
import 'package:import_website/core/database_classes/machines.dart';
import 'package:import_website/core/database_classes/spare_parts.dart';
import 'package:import_website/core/services/get_data.dart';
import 'package:import_website/modules/product_details/product_details_page.dart';

import '../../main/controllers/main_home_controller.dart';

class ServicesController extends GetxController {
  RxBool isLoading1 = true.obs;
  RxBool isLoadingMachines = true.obs;
  RxBool isLoadingMachinesPhotos = true.obs;
  RxBool isLoadingSpareParts = true.obs;
  RxBool isLoadingSparePartsPhotos = true.obs;
  final getData = Get.find<GetData>();
  RxList<Machines> machines = <Machines>[].obs;
  RxList<SpareParts> spareParts = <SpareParts>[].obs;
  final mainController = Get.find<MainHomeController>();

  var pagePhotos = <Map<String, dynamic>>[].obs; // List to hold photo data
  var machinesPhotos = <Map<String, dynamic>>[].obs; // List to hold photo data
  var sparePartsPhotos =
      <Map<String, dynamic>>[].obs; // List to hold photo data

  @override
  void onInit() {
    fetchData();

    super.onInit();
  }

  Future<void> fetchData() async {
    machines.value = await getData.getMachines();
    isLoadingMachines.value = false;

    spareParts.value = await getData.getSpareParts();
    isLoadingSpareParts.value = false;

    for (var i = 0; i < 1; i++) {
      String newString = machines[0]
          .photoPath
          .replaceFirst(RegExp(r'[^/]+$'), 'get_these.php?path=/');
      machinesPhotos.value =
          await mainController.fetchDataWithTimeout(newString) ?? [];
    }
    for (var m in machines) {
      m.photoPath = m.photoPath.split('/').last;
    }

    pagePhotos.value = await mainController.fetchPhotos(
          'files/services_page/photos/get_these.php?path=/',
        ) ??
        [];
    isLoading1.value = false;
  }

  void goToMachineDetailsPage(int machineId) {
    Get.toNamed("/machine/$machineId");
  }
}
