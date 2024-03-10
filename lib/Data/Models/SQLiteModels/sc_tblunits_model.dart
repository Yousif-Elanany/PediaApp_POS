class SCTblUnitsModel {
  int unitId;
  String unitNameAr;
  String unitNameEn;

  SCTblUnitsModel({
    required this.unitId,
    required this.unitNameAr,
    required this.unitNameEn,
  });

  factory SCTblUnitsModel.fromJson(Map<String, dynamic> json) {
    return SCTblUnitsModel(
      unitId: json['UnitId'],
      unitNameAr: json['UnitNameAr'],
      unitNameEn: json['UnitNameEn'],
    );
  }
}
