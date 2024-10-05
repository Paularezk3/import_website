import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:import_website/core/database_classes/product_details.dart';
import 'package:import_website/modules/product_details/product_details_page.dart';
import '../../core/database_classes/product_attributes_and_types.dart';

class SparePartsDetailsPage extends StatelessWidget {
  const SparePartsDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    SpareParts? sparePart;
    final sparePartId = Get.parameters['sparePartID'];
    final args = Get.arguments;
    if (args != null) {
      sparePart = args['spare_part'];
    }
    return SliverToBoxAdapter(
        child: ProductDetailsPage(
      productType: ProductType.spareParts,
      productId: int.parse(sparePartId ?? "-1"),
      sparePart: sparePart
    ));
  }
}
