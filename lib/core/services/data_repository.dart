import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:import_website/core/services/api_urls.dart';
import 'package:intl/intl.dart';

import 'debugging_test.dart';

class DataRepository {
  final serverHelper = ServerHelper();

  Future<List<dynamic>> fetchPostsFromServer() async {
    return await serverHelper.fetchData(
        'files/database/database/getPosts.php');
  }

  Future<void> addCustomerToNewsletterToServer(
      String name, String email, String errorString) async {
    return await serverHelper.postData(
        'files/database/database/setNewsletterCustomer.php',
        {'name': name, 'email': email},
        errorString);
  }

  Future<void> addCustomerInquiryToServer(
      String name, String email, String description, String errorString) async {
    return await serverHelper.postData(
        'files/database/database/setCustomerInquiry.php',
        {'name': name, 'email': email, 'description': description},
        errorString);
  }

  Future<void> updatingInvoiceOfferInServer(
      String transactionID, String date, String amount, String details) async {
    return await serverHelper.postData(
        'the_old_website/database/updateCustomerInvoiceOffer.php',
        {
          'transaction_id': transactionID,
          'new_date': date,
          'new_amount': amount,
          'new_details': details,
        },
        "Updating Invoice Offer");
  }

  Future<void> deleteInvoiceOfferFromServer(String transactionID) async {
    return await serverHelper.postData(
        'the_old_website/database/deleteInvoiceOffer.php',
        {
          'transactions_id': transactionID,
        },
        "Deleting Invoice Offer");
  }
}

class ServerHelper {
  static var random = Random.secure();
  static final secondKey = encrypt.Key.fromUtf8('G*Dfga&s#d3%g=M`');
  static final firstKey = encrypt.Key.fromUtf8('G4D~gA&0#.3i?vM{');
  static var values = List<int>.generate(16, (i) => random.nextInt(256));
  static var ivBase64 = base64Url.encode(values);
  static final iv = encrypt.IV.fromBase64(ivBase64);
  encrypt.Encrypter get _encrypter1 =>
      encrypt.Encrypter(encrypt.AES(firstKey, mode: encrypt.AESMode.cbc));
  encrypt.Encrypter get _encrypter2 =>
      encrypt.Encrypter(encrypt.AES(secondKey, mode: encrypt.AESMode.cbc));

  void doneSuccessfully(String h) {
    // ShowSnackBar.showDoneSnackBar("Successfully Done $h!");
    DebuggingTest.printSomething(h);
  }

  bool isSuccess(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  Future<List<dynamic>> fetchData(String path,
      [Map<String, String>? parameters]) async {
    String webHostUrl = ApiUrls.baseUrlWithoutHttps;
    DebuggingTest.printSomething("Fetching Something");
    var uri = Uri.https(webHostUrl, '/$path', parameters);
    final response = await http.get(uri, headers: {
    'Accept': 'application/json',
  }).timeout(const Duration(seconds: 10));
    if (isSuccess(response.statusCode)) {
      return jsonDecode(decrypt2Times(response.body))
          .map((item) => processData(item))
          .toList();
    } else {
      String error = decrypt2Times(response.body).toString();
      DebuggingTest.printSomething(error);
      throw Exception(error);
    }
  }

  Future<void> postData(
      String path, Map<String, String> body, String successfulText) async {
    String webHostUrl = ApiUrls.baseUrl;
    DebuggingTest.printSomething("Posting $successfulText: $body");

    body.forEach((key, value) {
      if (key != 'iv' && value != "") {
        body[key] = _encrypter2.encrypt(value, iv: iv).base64;
      }
    });
    body['iv'] = iv.base64;

    final uri = Uri.parse("$webHostUrl$path");
    final response =
        await http.post(uri, body: body).timeout(const Duration(seconds: 10));
    if (isSuccess(response.statusCode)) {
      DebuggingTest.printSomething(response.body);
      try {
        doneSuccessfully(jsonDecode(response.body)["message"]);
      } catch (e) {
        doneSuccessfully(response.body);
      }
    } else {
      throw Exception(jsonDecode(response.body)["error"]);
    }
  }

  String decrypt2Times(String responseBody) {
    try {
      var firstDecryption = jsonDecode(decryptWithCustomIV(
          responseBody, _encrypter1, "NZXCSj/fLEMIpCdEgImRfw=="));
      if (firstDecryption['data'] != null && firstDecryption['iv'] != null) {
        var decryptedData = decryptWithCustomIV(
            firstDecryption['data'], _encrypter2, firstDecryption['iv']);
        return decryptedData;
      } else {
        throw Exception("Decryption data or IV is missing");
      }
    } catch (e) {
      throw Exception("Decryption failed: $e");
    }
  }

  String decryptWithCustomIV(
      String responseBody, encrypt.Encrypter e, String base64Iv) {
    try {
      final iv = encrypt.IV.fromBase64(base64Iv);
      final encrypted = encrypt.Encrypted.from64(responseBody);
      final decrypted = e.decrypt(encrypted, iv: iv);
      return decrypted;
    } catch (e) {
      throw Exception("Decryption with custom IV failed: $e");
    }
  }

  Map<String, dynamic> processData(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value == null) {
        //value = "";
      } else if (value is int) {
        value = value.toString();
      } else if (value is double) {
        value = value.toString();
      }
      return MapEntry(key, value);
    });

    // else if (value is String) {
    //   int? intValue = int.tryParse(value);
    //   double? doubleValue = double.tryParse(value);

    //   if (intValue != null) {
    //     data[key] = intValue;
    //   } else if (doubleValue != null) {
    //     data[key] = doubleValue;
    //   }
    // }
  }
}
