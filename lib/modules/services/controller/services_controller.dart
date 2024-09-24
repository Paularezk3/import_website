import 'package:get/get.dart';
import 'package:import_website/core/database_classes/posts.dart';
import 'package:import_website/core/services/get_data.dart';

class ServicesController extends GetxController {
  RxBool isLoading = true.obs;
  final getData = Get.find<GetData>();
  RxList<Posts> posts = <Posts>[].obs;

  @override
  void onInit() {
    fetchData();

    super.onInit();
  }

  Future<void> fetchData() async {
    
    posts.value = await getData.getPosts();

    isLoading.value = false;
  }
}
