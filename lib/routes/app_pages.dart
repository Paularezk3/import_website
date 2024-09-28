import 'package:get/get.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:import_website/modules/main/main_home_view.dart';
import 'package:import_website/modules/product_details/machine_details_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: "/home",
      page: () => const MainHomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainHomeController>(() => MainHomeController());
      }),
    ),
    GetPage(
      name: "/machine/:argument",
      page: () => const MachineDetailsPage(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<MainHomeController>(() => MainHomeController());
      }),
    ),
    // Add more pages as needed
  ];
}
