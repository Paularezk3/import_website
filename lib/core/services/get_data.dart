import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_repository.dart';
import 'shared_preference_handler.dart';

class GetData extends GetxController {
  final NetworkRepository networkRepository;
  final SharedPreferencesHandler sharedPreferencesHandler;

  GetData({
    required this.networkRepository,
    required this.sharedPreferencesHandler,
  });

  Future<String> getText(String path, String key) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch from network and store in preferences
      String text = await networkRepository.fetchText(path);
      await sharedPreferencesHandler.saveText(key, text);
      return text;
    } else {
      // Fetch from preferences
      String? cachedText = await sharedPreferencesHandler.getText(key);
      if (cachedText != null) {
        return cachedText;
      } else {
        throw Exception('No internet and no cached data available');
      }
    }
  }

  Future<Uint8List> getImage(String path, String key) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch from network and store in preferences
      List<int> imageBytes = await networkRepository.fetchImage(path);
      await sharedPreferencesHandler.saveImage(key, imageBytes);
      return Uint8List.fromList(imageBytes);
    } else {
      // Fetch from preferences
      List<int>? cachedImage = await sharedPreferencesHandler.getImage(key);
      if (cachedImage != null) {
        return Uint8List.fromList(cachedImage);
      } else {
        throw Exception('No internet and no cached data available');
      }
    }
  }

  Future<Uint8List> getVideo(String path, String key) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch from network and store in preferences
      List<int> videoBytes = await networkRepository.fetchVideo(path);
      await sharedPreferencesHandler.saveVideo(key, videoBytes);
      return Uint8List.fromList(videoBytes);
    } else {
      // Fetch from preferences
      List<int>? cachedVideo = await sharedPreferencesHandler.getVideo(key);
      if (cachedVideo != null) {
        return Uint8List.fromList(cachedVideo);
      } else {
        throw Exception('No internet and no cached data available');
      }
    }
  }
}
