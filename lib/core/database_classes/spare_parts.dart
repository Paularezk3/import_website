class SpareParts {
  static const String partIdString = "part_id";
  int partId;

  static const String partNameEnString = "part_name_en";
  String partNameEn;

  static const String partNameArString = "part_name_ar";
  String partNameAr;

  static const String descriptionEnString = "description_en";
  String descriptionEn;

  static const String descriptionArString = "description_ar";
  String descriptionAr;

  static const String partTypeEnString = "part_type_en";
  String partTypeEn;

  static const String partTypeArString = "part_type_ar";
  String partTypeAr;

  static const String priceString = "price";
  double price;

  static const String quantityString = "quantity";
  int quantity;

  SpareParts({
    required this.partId,
    required this.partNameEn,
    required this.partNameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.partTypeEn,
    required this.partTypeAr,
    required this.price,
    required this.quantity,
  });

  factory SpareParts.fromJson(Map<String, dynamic> json) {
    return SpareParts(
      partId: int.parse(json[partIdString] ?? "0"),
      partNameEn: json[partNameEnString] ?? "",
      partNameAr: json[partNameArString] ?? "",
      descriptionEn: json[descriptionEnString] ?? "",
      descriptionAr: json[descriptionArString] ?? "",
      partTypeEn: json[partTypeEnString] ?? "",
      partTypeAr: json[partTypeArString] ?? "",
      price: double.parse(json[priceString] ?? "0.0"),
      quantity: int.parse(json[quantityString] ?? "0"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      partIdString: partId.toString(),
      partNameEnString: partNameEn,
      partNameArString: partNameAr,
      descriptionEnString: descriptionEn,
      descriptionArString: descriptionAr,
      partTypeEnString: partTypeEn,
      partTypeArString: partTypeAr,
      priceString: price.toString(),
      quantityString: quantity.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpareParts &&
        other.partId == partId &&
        other.partNameEn == partNameEn &&
        other.partNameAr == partNameAr &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.partTypeEn == partTypeEn &&
        other.partTypeAr == partTypeAr &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode =>
      partId.hashCode ^
      partNameEn.hashCode ^
      partNameAr.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      partTypeEn.hashCode ^
      partTypeAr.hashCode ^
      price.hashCode ^
      quantity.hashCode;
}

List<SpareParts> parseSparePartsListItems(List<dynamic> jsoned) {
  return jsoned.map<SpareParts>((item) => SpareParts.fromJson(item)).toList();
}
