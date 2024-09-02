import 'package:http/http.dart' as http;

class NetworkRepository {
  final String baseUrl;

  NetworkRepository({required this.baseUrl});

  Future<String> fetchText(String path) async {
    final response = await http.get(Uri.parse('$baseUrl/$path'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load text');
    }
  }

  Future<List<int>> fetchImage(String path) async {
    final response = await http.get(Uri.parse('$baseUrl/$path'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<List<int>> fetchVideo(String path) async {
    final response = await http.get(Uri.parse('$baseUrl/$path'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load video');
    }
  }
}
