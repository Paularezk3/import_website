import 'dart:ui';

import 'package:get/get.dart';
import 'package:import_website/core/services/shared_preference_handler.dart';

import 'language_translations.dart';

class TranslationService extends Translations {
  static final _pref = SharedPreferencesHandler();
  static const fallbackLocale = Locale('ar', 'EG');
  static Rx<Locale> currentLang = Rx<Locale>(Get.deviceLocale ?? const Locale("en"));
  static const _localeKey = 'locale';

  static Future<Locale?> get locale async {
    String? localeCode = await _pref.getText(_localeKey);
    if (localeCode != null) {
      var localeSplit = localeCode.split('_');
      return Locale(localeSplit[0], localeSplit[1]);
    }
    currentLang.value = Get.deviceLocale ?? const Locale("en");
    return Get.deviceLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ar_EG': arEG,
      };

  static void saveLocale(Locale locale) {
    _pref.saveText(_localeKey, locale.toString());
  }

  static Future<void> changeLanguage(Locale newValue) async {
    TranslationService.saveLocale(newValue);
    currentLang.value = newValue;
    Get.updateLocale(newValue);
  }
}
