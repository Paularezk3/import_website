// lib/modules/home/controllers/home_controller.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/api_urls.dart';
import '../../../core/services/debugging_test.dart';
import '../../../core/services/get_data.dart';

enum WebsiteView { home, ourProducts, contactUs, services, machineDetails, sparePartDetails }

class MainHomeController extends GetxController {
  
  Rx<WebsiteView> currentPage = WebsiteView.home.obs;
  RxBool isSubmitted = false.obs;


  void switchWebsiteViewWithoutRebuild(WebsiteView newValue) {
    currentPage = newValue.obs;
  }
  void switchWebsiteView(WebsiteView newValue) {
    currentPage.value = newValue;
    update();
  }

  void submitEmail(String name, String email) {
    isSubmitted.value = true;
    Get.find<GetData>().addCustomerToNewsletter(name, email);
    isSubmitted.value = false;
  }

  Future<void> submitInquiry(String name, String email, String description) async{
    isSubmitted.value = true;
    await Get.find<GetData>().addCustomerInquiry(name, email, description);
    isSubmitted.value = false;
  }

  // Method to fetch base64-encoded photos from the PHP API
  /// url = '${ApiUrls.baseUrl}files/homepage/photos/get_these.php?path=/'
  /// "${ApiUrls.baseUrl}$url"
  Future<List<Map<String, dynamic>>?> fetchPhotos(String url) async {
    try {
      final response = await http.get(Uri.parse('${ApiUrls.baseUrl}$url'));

      if (response.statusCode == 200) {
        // Decode the response body into a Map (since the root JSON object is a map)
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract the values of the map and convert them to a list
        List<Map<String, dynamic>> tempPhotos = responseData.values
            .map((item) => item as Map<String, dynamic>)
            .toList();

        // Decode base64Content for each image
        for (var img in tempPhotos) {
          img['base64Content'] = base64ToImage(img['base64Content']);
        }

        return tempPhotos;
      } else {
        DebuggingTest.printSomething(
            'Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      DebuggingTest.printSomething('Error fetching photos: $e');
    }
    return null;
  }

  /// Method to decode base64 to a Uint8List (required for Image.memory)
  Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }

  /// url = '${ApiUrls.baseUrl}files/homepage/photos/get_these.php?path=/'
  /// "${ApiUrls.baseUrl}$url"
  /// and timeout default = 4
  Future<List<Map<String, dynamic>>?> fetchDataWithTimeout(String url,
      {int timeoutSeconds = 3}) async {
    try {
      // Use Future.any to check which future completes first
      final result = await Future.any([
        fetchPhotos(
            url), // Assuming fetchPhotos returns List<Map<String, dynamic>>
        Future.delayed(Duration(seconds: timeoutSeconds), () => null),
      ]);

      // If the result is from fetchPhotos, it will be a list, otherwise, null (timeout)
      return result;
    } catch (error) {
      DebuggingTest.printSomething(
          'Error occurred while fetching photos: $error');
      return null;
    }
  }
}
