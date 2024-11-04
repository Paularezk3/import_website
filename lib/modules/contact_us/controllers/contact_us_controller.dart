import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:import_website/core/services/debugging_test.dart';
import 'dart:convert';
import 'dart:html' as html;

import '../../../core/services/get_data.dart';

class ContactUsController extends GetxController {
  var publicIP = "";
  RxBool isPermissionAvailable = false.obs;

  Future<void> collectAndSendData() async {
    var ipResponse =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    var ipData = json.decode(ipResponse.body);
    if (publicIP == ipData['ip']) return;
    publicIP = ipData['ip'];

    // 3. Get Geolocation using dart:html
    try {
      await DebuggingTest.loadSomething(4);
      getLocation();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> getLocation() async {
    // Check geolocation permission using the Permissions API
    html.window.navigator.permissions
        ?.query({"name": "geolocation"}).then((result) async {
      if (result.state == "granted") {
        // Permission granted, get the location
        html.window.navigator.geolocation
            .getCurrentPosition(enableHighAccuracy: true)
            .then((g) {
          if (g.coords?.latitude == 0) {
            return;
          }
          isPermissionAvailable.value = true;
          sendDataToServer(html.window.navigator.userAgent, publicIP,
              g.coords?.latitude ?? 0, g.coords?.longitude ?? 0);
        });
      } else if (result.state == "denied") {
        // Permission denied
        isPermissionAvailable.value = false;
      } else if (result.state == "prompt") {
        // Permission denied

        await DebuggingTest.loadSomething(4);
        getLocation();
      } else {
        // Permission needs to be requested
        DebuggingTest.printSomething(
            "Location permission is not yet requested, requesting now...");
        requestLocationPermission();
      }
    });
  }

// Function to request location permission
  void requestLocationPermission() {
    html.window.navigator.geolocation
        .getCurrentPosition(
      enableHighAccuracy: true,
    )
        .then((g) {
      if (g.coords?.latitude == 0) {
        return;
      }
      sendDataToServer(html.window.navigator.userAgent, publicIP,
          g.coords?.latitude ?? 0, g.coords?.longitude ?? 0);

      isPermissionAvailable.value = true;
    });
  }

  Future<void> sendDataToServer(
      String userAgent, String ipAddress, num? latitude, num? longitude) async {
    Get.find<GetData>().addInfos(userAgent, ipAddress,
        latitude?.toString() ?? "null", longitude?.toString() ?? "null");
  }
}
