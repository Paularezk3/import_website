import 'package:get/get.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:import_website/modules/main/main_home_view.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const MainHomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainHomeController>(() => MainHomeController());
      }),
    ),
    // Add more pages as needed
  ];
}
