abstract class Product {
  int id;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String typeEn;
  String typeAr;
  double price;
  int quantity;
  String photoPath;
  String photoName;

  Product({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.typeEn,
    required this.typeAr,
    required this.price,
    required this.quantity,
    required this.photoName,
    required this.photoPath,
  });
}

class Machines extends Product {
  static const String machineIdString = "machine_id";
  static const String machineNameEnString = "machine_name_en";
  static const String machineNameArString = "machine_name_ar";
  static const String descriptionEnString = "description_en";
  static const String descriptionArString = "description_ar";
  static const String machineTypeEnString = "machine_type_en";
  static const String machineTypeArString = "machine_type_ar";
  static const String priceString = "price";
  static const String quantityString = "quantity";
  static const String photoPathString = "photo_path";
  static const String photoNameString = "photo_name";

  Machines(
      {required int machineId,
      required String machineNameEn,
      required String machineNameAr,
      required super.descriptionEn,
      required super.descriptionAr,
      required String machineTypeEn,
      required String machineTypeAr,
      required super.price,
      required super.quantity,
      required super.photoPath,
      required super.photoName})
      : super(
          id: machineId,
          nameEn: machineNameEn,
          nameAr: machineNameAr,
          typeEn: machineTypeEn,
          typeAr: machineTypeAr,
        );

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
      photoPath: json[photoPathString] ?? "",
      photoName: json[photoNameString] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      machineIdString: id.toString(),
      machineNameEnString: nameEn,
      machineNameArString: nameAr,
      descriptionEnString: descriptionEn,
      descriptionArString: descriptionAr,
      machineTypeEnString: typeEn,
      machineTypeArString: typeAr,
      priceString: price.toString(),
      quantityString: quantity.toString(),
      photoPathString: photoPath,
      photoNameString: photoName,
    };
  }
}

class SpareParts extends Product {
  static const String partIdString = "part_id";
  static const String partNameEnString = "part_name_en";
  static const String partNameArString = "part_name_ar";
  static const String descriptionEnString = "description_en";
  static const String descriptionArString = "description_ar";
  static const String partTypeEnString = "part_type_en";
  static const String partTypeArString = "part_type_ar";
  static const String priceString = "price";
  static const String quantityString = "quantity";
  static const String photoPathString = "photo_path";
  static const String photoNameString = "photo_name";

  SpareParts(
      {required int partId,
      required String partNameEn,
      required String partNameAr,
      required super.descriptionEn,
      required super.descriptionAr,
      required String partTypeEn,
      required String partTypeAr,
      required super.price,
      required super.quantity,
      required super.photoName,
      required super.photoPath})
      : super(
          id: partId,
          nameEn: partNameEn,
          nameAr: partNameAr,
          typeEn: partTypeEn,
          typeAr: partTypeAr,
        );

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
      photoPath: json[photoPathString] ?? "",
      photoName: json[photoNameString] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      partIdString: id.toString(),
      partNameEnString: nameEn,
      partNameArString: nameAr,
      descriptionEnString: descriptionEn,
      descriptionArString: descriptionAr,
      partTypeEnString: typeEn,
      partTypeArString: typeAr,
      priceString: price.toString(),
      quantityString: quantity.toString(),
      photoPathString: photoPath,
      photoNameString: photoName,
    };
  }
}

List<Machines> parseMachinesListItems(List<dynamic> jsoned) {
  return jsoned.map<Machines>((item) => Machines.fromJson(item)).toList();
}

List<SpareParts> parseSparePartsListItems(List<dynamic> jsoned) {
  return jsoned.map<SpareParts>((item) => SpareParts.fromJson(item)).toList();
}
