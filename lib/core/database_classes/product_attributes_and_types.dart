class ProductAttributesAndTypes {
  // Common fields between attributes and machine types
  int id;
  String nameEn;
  String nameAr;
  double? price;
  int? quantity;
  String? attributeNameEn;
  String? attributeNameAr;
  String? attributeValueEn;
  String? attributeValueAr;
  String source;
  ProductType entityType;

  // Constructor for machine type
  ProductAttributesAndTypes.machineType({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.quantity,
    required this.entityType,
  })  : attributeNameEn = null,
        attributeNameAr = null,
        attributeValueEn = null,
        attributeValueAr = null,
        source = 'type';

  // Constructor for attributes
  ProductAttributesAndTypes.attribute({
    required this.id,
    required this.attributeNameEn,
    required this.attributeNameAr,
    required this.attributeValueEn,
    required this.attributeValueAr,
    required this.entityType,
  })  : nameEn = '',
        nameAr = '',
        price = null,
        quantity = null,
        source = 'attribute';

  // Factory method to create the appropriate object
  factory ProductAttributesAndTypes.fromJson(Map<String, dynamic> json) {
    ProductType entityType = json['entity_type'] == 'machine'
        ? ProductType.machine
        : ProductType.spareParts;

    if (json['source'] == 'type') {
      return ProductAttributesAndTypes.machineType(
        id: int.parse(json['machine_id'] ?? "0"),
        nameEn: json['type_name_en'] ?? '',
        nameAr: json['type_name_ar'] ?? '',
        price: double.tryParse(json['type_price'] ?? "0.0"),
        quantity: int.tryParse(json['type_quantity'] ?? "0"),
        entityType: entityType,
      );
    } else if (json['source'] == 'attribute') {
      return ProductAttributesAndTypes.attribute(
        id: int.parse(json['machine_id'] ?? "0"),
        attributeNameEn: json['attribute_name_en'] ?? '',
        attributeNameAr: json['attribute_name_ar'] ?? '',
        attributeValueEn: json['attribute_value_en'] ?? '',
        attributeValueAr: json['attribute_value_ar'] ?? '',
        entityType: entityType,
      );
    }
    throw Exception("Unknown source type");
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    if (source == 'type') {
      return {
        'machine_id': id.toString(),
        'type_name_en': nameEn,
        'type_name_ar': nameAr,
        'type_price': price?.toString(),
        'type_quantity': quantity?.toString(),
        'source': source,
        'entity_type':
            entityType.toString().split('.').last, // Convert enum to string
      };
    } else {
      return {
        'machine_id': id.toString(),
        'attribute_name_en': attributeNameEn,
        'attribute_name_ar': attributeNameAr,
        'attribute_value_en': attributeValueEn,
        'attribute_value_ar': attributeValueAr,
        'source': source,
        'entity_type':
            entityType.toString().split('.').last, // Convert enum to string
      };
    }
  }
}

enum ProductType { machine, spareParts }

// Parsing List Example:
List<ProductAttributesAndTypes> parseProductAttributesAndTypesListItems(
    List<dynamic> jsonList) {
  return jsonList
      .map((item) => ProductAttributesAndTypes.fromJson(item))
      .toList();
}
