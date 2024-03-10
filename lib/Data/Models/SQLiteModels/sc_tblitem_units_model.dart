class SCTblItemUnitsModel {
  int itemID;
  int unitId;
  int recId;
  double convParm;
  String unitName;

  SCTblItemUnitsModel({
    required this.itemID,
    required this.unitId,
    required this.recId,
    required this.convParm,
    required this.unitName,
  });

  factory SCTblItemUnitsModel.fromJson(Map<String, dynamic> json) {
    return SCTblItemUnitsModel(
      itemID: json['ItemID'] == null ? 0 : json["ItemID"],
      unitId: json['UnitId'],
      recId: json['RecId'],
      convParm: json['ConvParm'],
      unitName: json['UnitName'],
    );
  }
}
