import 'package:get/get.dart';
import 'package:import_website/core/utils/app_constants.dart';
import 'package:import_website/modules/home/controllers/main_home_controller.dart';

import '../services/get_data.dart';
import '../services/network_repository.dart';
import '../services/shared_preference_handler.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomeController>(() => MainHomeController());
    // Add more dependencies if needed
    // Initialize NetworkRepository and SharedPreferencesHandler
    Get.put<NetworkRepository>(
      NetworkRepository(baseUrl: 'https://${AppConstants.apiUrl}'),
    );
    Get.put<SharedPreferencesHandler>(SharedPreferencesHandler());

    // Initialize GetData and inject NetworkRepository and SharedPreferencesHandler
    Get.put<GetData>(GetData(
          networkRepository: Get.find<NetworkRepository>(),
          sharedPreferencesHandler: Get.find<SharedPreferencesHandler>(),
        ));
  }
}