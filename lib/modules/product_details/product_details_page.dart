import 'package:flutter/material.dart';

enum ProductType{
  machine, spareParts
}

class ProductDetailsPage extends StatelessWidget {
  final ProductType productType;
  const ProductDetailsPage({required this.productType, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}