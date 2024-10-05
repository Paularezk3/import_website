import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:import_website/routes/pages_names.dart';
import 'package:video_player/video_player.dart';
import '../../../core/services/api_urls.dart';
import '../../main/controllers/main_home_controller.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isMobile = true.obs;
  final mainController = Get.find<MainHomeController>();
  late Rx<VideoPlayerController> videoPlayerController;
  late Rx<Future<void>> initializeVideoPlayerFuture;
  late Rx<ChewieController> chewieController;
  RxString videoError = ''.obs;
  int retryCount = 0;
  final int maxRetries = 3;
  var photos = <Map<String, dynamic>>[].obs; // List to hold photo data

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    videoError.value = ''; // Reset error message
    retryCount = 0;

    // Create video player controller
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(ApiUrls.homePagevideo1Url),
    ).obs;

    // Initialize the video
    await _initializeVideoWithRetry();

    isLoading.value = false;
    update();
    // Fetch data with timeout
    photos.value = await mainController.fetchPhotos(
          'files/homepage/photos/get_these.php?path=/',
        ) ??
        [];
  }

  // Retry logic for video initialization
  Future<void> _initializeVideoWithRetry() async {
    while (retryCount < maxRetries) {
      try {
        initializeVideoPlayerFuture =
            videoPlayerController.value.initialize().obs;
        await initializeVideoPlayerFuture.value;

        // Create Chewie controller once video is ready
        chewieController = ChewieController(
          showControls: false,
          showOptions: false,
          showControlsOnInitialize: false,
          videoPlayerController: videoPlayerController.value,
          looping: true,
          autoPlay: true,
        ).obs;

        return; // Exit on success
      } catch (error) {
        retryCount++;
        videoError.value = 'Attempt $retryCount failed. Retrying...';

        // Stop retrying after max retries
        if (retryCount >= maxRetries) {
          videoError.value = 'Failed to load video after several attempts.';
          break;
        }

        // Wait before retrying
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  void changeIsMobile(bool newValue) {
    isMobile.value = newValue;
  }

  void goToContactUsPage(){
    Get.toNamed(PagesNames.contactUs);
  }

  void goToOurProductsPage() {
    Get.toNamed(PagesNames.ourProducts);
  }
}
