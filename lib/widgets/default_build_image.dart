import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:import_website/modules/main/controllers/main_home_controller.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import '../core/services/api_urls.dart';
import '../core/utils/app_colors.dart';

/// Updated fetchImage method to accept a file name (${ApiUrls.baseUrl}files/homepage/photos/get_this.php?path=$fileName)
Future<http.Response> fetchImage(String fileName, String? filePath) async {
  final String url = filePath != null
      ? '${ApiUrls.baseUrl}${filePath}get_this.php?path=$fileName'
      : (Get.find<MainHomeController>().currentPage.value == WebsiteView.home
          ? '${ApiUrls.baseUrl}files/homepage/photos/get_this.php?path=$fileName'
          : '${ApiUrls.baseUrl}files/services_page/photos/get_this.php?path=$fileName');

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load image');
  }
}

Widget buildImage(String fileName, List<Map<String, dynamic>>? photos,
    {
    double? height = 400,
    bool roundedCorners = true,
    String? filePath}) {

      var imageBytes;
  if (photos != null) {
    final imageEntry = photos.firstWhere(
      (photo) => photo['fileName'] == fileName,
      orElse: () => {'base64Content': null}, // Provide a valid map entry
    );

    imageBytes = imageEntry['base64Content'];
  }
  if (imageBytes == null) {
    return FutureBuilder<http.Response>(
      future: fetchImage(fileName, filePath),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Replace CircularProgressIndicator with Shimmer effect
          return Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor(context),
            highlightColor: AppColors.shimmerHighlightColor(context),
            child: Container(
              width: double.infinity,
              height: height ?? 200.0, // Set your desired height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: roundedCorners
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.zero,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.broken_image_outlined));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Icon(Icons.error_outlined));
        } else {
          // Decode the response body to get the image data
          final imageBytes = snapshot.data!.bodyBytes;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: roundedCorners
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.zero,
                child: Image.memory(
                  imageBytes,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Text('Failed to display image'),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius:
            roundedCorners ? BorderRadius.circular(12.0) : BorderRadius.zero,
        child: Image.memory(
          imageBytes,
          fit:
              BoxFit.cover, // Ensure image covers the widget without distortion
          width: double.infinity, // Stretch to fill available width
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Center(
              child: Text('Failed to display image'),
            );
          },
        ),
      ),
    );
  }
}
