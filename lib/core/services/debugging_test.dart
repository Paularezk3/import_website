import 'package:flutter/foundation.dart';

class DebuggingTest{
  static Future<void> loadSomething(int seconds) async {
  printSomething('Start loading...');

  // Simulate a delay
  await Future.delayed(Duration(seconds: seconds));

  printSomething('Finished laoading.');
}

  static void printSomething(String something) async {
   if (kDebugMode) print(something);
  }


}