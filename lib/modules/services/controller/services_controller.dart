import 'package:get/get.dart';
import 'package:import_website/core/services/get_data.dart';

import '../../../core/database_classes/product_details.dart';
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

    String newString = '${machines[0].photoPath}get_these.php?path=/';
    machinesPhotos.value =
        await mainController.fetchDataWithTimeout(newString, timeoutSeconds: 5) ?? [];
    isLoadingMachinesPhotos.value = false;

    newString = '${spareParts[0].photoPath}get_these.php?path=/';
    sparePartsPhotos.value =
        await mainController.fetchDataWithTimeout(newString, timeoutSeconds: 5) ?? [];
    isLoadingSparePartsPhotos.value = false;

    pagePhotos.value = await mainController.fetchPhotos(
          'files/services_page/photos/get_these.php?path=/',
        ) ??
        [];
    isLoading1.value = false;
  }

  void goToMachineDetailsPage(Machines machine) {
    Get.toNamed("/machine/${machine.id}", arguments: {"machine": machine});
  }

  void goToSparePartDetailsPage(SpareParts sparePart) {
    Get.toNamed("/spare_part/${sparePart.id}", arguments: {"spare_part": sparePart});
  }
}
