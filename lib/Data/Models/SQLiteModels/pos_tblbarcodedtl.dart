class PosTblBarcodeDtl {
  int unitId;
  int itemId;
  String barcode;
  String codeDtl;

  PosTblBarcodeDtl({
    required this.unitId,
    required this.itemId,
    required this.barcode,
    required this.codeDtl,
  });

  factory PosTblBarcodeDtl.fromJson(Map<String, dynamic> json) {
    return PosTblBarcodeDtl(
      unitId: json['unitId'],
      itemId: json['itemId'],
      barcode: json['barcode'],
      codeDtl: json['codeDtl'],
    );
  }
}