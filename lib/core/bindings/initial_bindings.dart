import 'package:get/get.dart';
import 'package:import_website/core/services/data_repository.dart';
import 'package:import_website/core/services/get_data.dart';
import 'package:import_website/core/services/prefs_helper.dart';
import 'package:import_website/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:import_website/modules/services/controller/services_controller.dart';
import '../services/getting_infos.dart';
import '../services/shared_preference_handler.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    DataRepository dataRepository = DataRepository();
    PrefsHelper prefs = PrefsHelper();
    Get.put(GetData(dataRepository, prefs));
    Get.put<GettingInfos>(GettingInfos());
    Get.put<MainHomeController>(MainHomeController());
    Get.put<HomeController>(HomeController());
    Get.put<ContactUsController>(ContactUsController());
    Get.put<ServicesController>(ServicesController());
    // Add more dependencies if needed
    Get.put<SharedPreferencesHandler>(SharedPreferencesHandler());
  }
}