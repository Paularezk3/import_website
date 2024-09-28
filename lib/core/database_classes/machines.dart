class Machines {
  static const String machineIdString = "machine_id";
  int machineId;

  static const String machineNameEnString = "machine_name_en";
  String machineNameEn;

  static const String machineNameArString = "machine_name_ar";
  String machineNameAr;

  static const String descriptionEnString = "description_en";
  String descriptionEn;

  static const String descriptionArString = "description_ar";
  String descriptionAr;

  static const String machineTypeEnString = "machine_type_en";
  String machineTypeEn;

  static const String machineTypeArString = "machine_type_ar";
  String machineTypeAr;

  static const String priceString = "price";
  double price;

  static const String quantityString = "quantity";
  int quantity;

  static const String photoPathString = "photo_path";
  String photoPath;

  Machines({
    required this.machineId,
    required this.machineNameEn,
    required this.machineNameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.machineTypeEn,
    required this.machineTypeAr,
    required this.price,
    required this.quantity,
    required this.photoPath
  });

  factory Machines.fromJson(Map<String, dynamic> json) {
    return Machines(
      machineId: int.parse(json[machineIdString] ?? "0"),
      machineNameEn: json[machineNameEnString] ?? "",
      machineNameAr: json[machineNameArString] ?? "",
      descriptionEn: json[descriptionEnString] ?? "",
      descriptionAr: json[descriptionArString] ?? "",
      machineTypeEn: json[machineTypeEnString] ?? "",
      machineTypeAr: json[machineTypeArString] ?? "",
      price: double.parse(json[priceString] ?? "0.0"),
      quantity: int.parse(json[quantityString] ?? "0"),
      photoPath: json[photoPathString] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      machineIdString: machineId.toString(),
      machineNameEnString: machineNameEn,
      machineNameArString: machineNameAr,
      descriptionEnString: descriptionEn,
      descriptionArString: descriptionAr,
      machineTypeEnString: machineTypeEn,
      machineTypeArString: machineTypeAr,
      priceString: price.toString(),
      quantityString: quantity.toString(),
      photoPathString: photoPath
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Machines &&
        other.machineId == machineId &&
        other.machineNameEn == machineNameEn &&
        other.machineNameAr == machineNameAr &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.machineTypeEn == machineTypeEn &&
        other.machineTypeAr == machineTypeAr &&
        other.price == price &&
        other.quantity == quantity &&
        other.photoPath == photoPath;
  }

  @override
  int get hashCode =>
      machineId.hashCode ^
      machineNameEn.hashCode ^
      machineNameAr.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      machineTypeEn.hashCode ^
      machineTypeAr.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      photoPath.hashCode;
}

List<Machines> parseMachinesListItems(List<dynamic> jsoned) {
  return jsoned.map<Machines>((item) => Machines.fromJson(item)).toList();
}
