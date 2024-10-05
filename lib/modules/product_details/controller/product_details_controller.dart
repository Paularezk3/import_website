import 'package:get/get.dart';
import 'package:import_website/core/database_classes/product_attributes_and_types.dart';
import 'package:import_website/core/services/get_data.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';
import '../../../core/database_classes/product_details.dart';

class ProductDetailsController extends GetxController {
  RxBool isLoading1 = true.obs;
  RxBool isLoadingAttributes = true.obs;
  RxBool isLoadingMachineSpareParts = true.obs;
  final servicesController = Get.find<ServicesController>();
  final getDataController = Get.find<GetData>();

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
}
