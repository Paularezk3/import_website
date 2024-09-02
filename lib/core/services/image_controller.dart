import 'package:get/get.dart';
import 'get_data.dart';
import 'dart:typed_data';

class ImageController extends GetxController {
  final GetData getData = Get.find<GetData>(); // Retrieve the GetData instance

  // Observable list to store the images as Uint8List
  var images = <Uint8List>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImage();
  }

  void fetchImage() async {
    try {
      // Fetch the image using GetData, specifying the path and key for caching
      Uint8List image = await getData.getImage('/files/home_page/images/20220817_101053.jpg', 'homePageImage1');
      images.add(image); // Add the fetched image to the observable list
    } catch (e) {
      print('Error fetching image: $e');
    }
  }
}
