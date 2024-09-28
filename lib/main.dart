// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:import_website/core/bindings/initial_bindings.dart';
import 'package:import_website/core/utils/app_constants.dart';
import 'package:import_website/core/utils/app_theme.dart';
import 'package:import_website/routes/app_pages.dart';

import 'core/utils/translation/translation_service.dart';
// import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.companyShortName,
      theme: AppTheme.lightTheme(context), // Light theme
      darkTheme: AppTheme.darkTheme(context), // Dark theme
      themeMode: ThemeMode.light, // Switch based on system preference
      // themeMode: ThemeMode.system, // Switch based on system preference
      translations: TranslationService(),
      locale: Get.deviceLocale, // Get.deviceLocale or default
      fallbackLocale: TranslationService.fallbackLocale,
      initialBinding: InitialBindings(),
      initialRoute: '/home',
      getPages: AppPages.routes,
    );
  }
}
