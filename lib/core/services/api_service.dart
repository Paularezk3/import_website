import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_urls.dart';

class ApiService extends GetxService {
  // Fetch data for a specific page and type (e.g., photos, videos, text)
  Future<List<String>> fetchData(String page, String type) async {
    String url;

    // Determine the API URL based on the page and type
    switch (page) {
      case 'homepage':
        url = _getUrlForType(ApiUrls.homePhotosUrl, ApiUrls.homeVideosUrl, ApiUrls.homeTextUrl, type);
        break;
      case 'aboutpage':
        url = _getUrlForType(ApiUrls.aboutPhotosUrl, ApiUrls.aboutVideosUrl, ApiUrls.aboutTextUrl, type);
        break;
      default:
        throw Exception('Invalid page name');
    }

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        // Assuming the API returns a list of image URLs in JSON format
        List<dynamic> data = jsonDecode(response.body);
        
        // Convert to List<String>
        return data.cast<String>();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Helper function to return the correct URL based on the type (photos, videos, text)
  String _getUrlForType(String photosUrl, String videosUrl, String textUrl, String type) {
    switch (type) {
      case 'photos':
        return photosUrl;
      case 'videos':
        return videosUrl;
      case 'text':
        return textUrl;
      default:
        throw Exception('Invalid data type');
    }
  }
}
