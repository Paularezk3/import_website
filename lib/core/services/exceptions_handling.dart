
import 'debugging_test.dart';

class ExceptionsHandling {
  static Future<void> logExceptionToServer(
      Object exception, StackTrace stackTrace, String level) async {

    Map<String, String> body = {
      'stackTrace': stackTrace.toString(),
      'channel': 'flutter',
      'level': level,
      'message': exception.toString(),
      'time': DateTime.now().toUtc().toIso8601String().split('.')[0],
    };
    DebuggingTest.printSomething("Posting Exception $body");

    try {
      // Get a reference to the Firestore collection
      // CollectionReference problems =
      //     FirebaseFirestore.instance.collection('problems');

      // // Get a reference to the 'bugsAppReport' document
      // DocumentReference bugsAppReport = problems.doc('bugsAppReport');

      // Add the error log to a new document with an auto-generated ID under 'bugsAppReport'
      // bugsAppReport.collection('reports').add(body).then((docRef) {
      //   DebuggingTest.printSomething(
      //       "Error Submitted on Firestore with ID: ${docRef.id}");
      // });
    } catch (e) {
      // Handle or ignore errors in sending the error log
      // Avoid recursive logging
      DebuggingTest.printSomething(e.toString());
    }
  }
}
