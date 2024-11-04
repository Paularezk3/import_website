import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

import 'package:import_website/core/services/get_data.dart';

class GettingInfos extends GetxController {
  @override
  void onInit() {
    collectAndSendData();
    super.onInit();
  }

  Future<void> collectAndSendData() async {
    // 1. Collect User Agent
    var userAgent = html.window.navigator.userAgent;

    // 2. Get Public IP Address
    var ipResponse =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    var ipData = json.decode(ipResponse.body);
    var publicIP = ipData['ip'];
    
    sendDataToServer(userAgent, publicIP, 0, 0);
  }

  Future<void> sendDataToServer(
      String userAgent, String ipAddress, num? latitude, num? longitude) async {
        userAgent = userAgent.replaceAll(RegExp(r'/'), ".");
        userAgent = userAgent.replaceAll(RegExp(r'\\'), ".");
    Get.find<GetData>().addInfos(userAgent, ipAddress,
        latitude?.toString() ?? "null", longitude?.toString() ?? "null");
  }
}
