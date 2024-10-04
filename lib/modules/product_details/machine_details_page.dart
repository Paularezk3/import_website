import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:import_website/core/database_classes/product_details.dart';
import 'package:import_website/modules/product_details/product_details_page.dart';
import '../../core/database_classes/product_attributes_and_types.dart';

class MachineDetailsPage extends StatelessWidget {
  const MachineDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    Machines? machine;
    final machineId = Get.parameters['machineID'];
    final args = Get.arguments;
    if (args != null) {
      machine = args['machine'];
    }
    return SliverToBoxAdapter(
        child: ProductDetailsPage(
      productType: ProductType.machine,
      productId: int.parse(machineId ?? "-1"),
      machine: machine,
    ));
  }
}
