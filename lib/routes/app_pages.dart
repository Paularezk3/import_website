import 'package:get/get.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:import_website/modules/main/main_home_view.dart';
import 'package:import_website/routes/pages_names.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: PagesNames.home,
      page: () => const MainHomeView(page: WebsiteView.home,),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainHomeController>(() => MainHomeController());
      }),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    GetPage(
      name: PagesNames.services,
      page: () => const MainHomeView(page: WebsiteView.services,),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    GetPage(
      name: PagesNames.contactUs,
      page: () => const MainHomeView(page: WebsiteView.contactUs,),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    GetPage(
      name: PagesNames.ourProducts,
      page: () => const MainHomeView(page: WebsiteView.ourProducts,),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    GetPage(
      name: PagesNames.machineDetailsPage,
      page: () => const MainHomeView(page: WebsiteView.machineDetails,),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    GetPage(
      name: PagesNames.sparePartsDetailsPage,
      page: () => const MainHomeView(page: WebsiteView.sparePartDetails,),
      fullscreenDialog: true,
      transition: Transition.noTransition
    ),
    // Add more pages as needed
  ];
}
