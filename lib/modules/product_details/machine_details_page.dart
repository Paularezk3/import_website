import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:import_website/core/services/debugging_test.dart';
import 'package:import_website/modules/product_details/product_details_page.dart';

class MachineDetailsPage extends StatelessWidget {
  const MachineDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = Get.parameters['argument'];
    DebuggingTest.printSomething(argument??"");
    return const ProductDetailsPage(productType: ProductType.machine, );
  }
}
