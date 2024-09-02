import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  Future<void> saveText(String key, String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future<String?> getText(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveImage(String key, List<int> imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, base64Encode(imageBytes));
  }

  Future<List<int>?> getImage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString(key);
    if (base64Image != null) {
      return base64Decode(base64Image);
    }
    return null;
  }

  Future<void> saveVideo(String key, List<int> videoBytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, base64Encode(videoBytes));
  }

  Future<List<int>?> getVideo(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? base64Video = prefs.getString(key);
    if (base64Video != null) {
      return base64Decode(base64Video);
    }
    return null;
  }
}
