class FillSearchModel {
  int itemID;
  String unitName;
  double convParm;
  int unitId;
  double itemPrice;
  double itemPrice1;
  double itemPrice1M;
  double itemPrice2;
  double itemPrice3;
  double avregcost;
  int priceOrder;
  double currentStock;
  double convParmStock;
  double discVal;

  FillSearchModel({
    required this.itemID,
    required this.unitName,
    required this.convParm,
    required this.unitId,
    required this.itemPrice,
    required this.itemPrice1,
    required this.itemPrice1M,
    required this.itemPrice2,
    required this.itemPrice3,
    required this.avregcost,
    required this.priceOrder,
    required this.currentStock,
    required this.convParmStock,
    required this.discVal,
  });

  FillSearchModel.fromJson(Map<String, dynamic> json):
        itemID= json['ItemID'],
        unitName= json['UnitName'],
        convParm= (json['ConvParm'] ??0.0).toDouble(),
        unitId= json['UnitId'],
        itemPrice= (json['ItemPrice'] ??0.0).toDouble(),
        itemPrice1= (json['ItemPrice1'] ??0.0).toDouble(),
        itemPrice1M= (json['ItemPrice1M'] ??0.0).toDouble(),
        itemPrice2= (json['ItemPrice2'] ??0.0).toDouble(),
        itemPrice3= (json['ItemPrice3'] ??0.0).toDouble(),
        avregcost= (json['AvregCost'] ??0.0).toDouble(),
        priceOrder= json['PriceOrder'],
        currentStock= (json['CurrentStock'] ??0.0).toDouble(),
        convParmStock= (json['ConvParm_Stock'] ??0.0).toDouble(),
        discVal= (json['DiscVal'] as num).toDouble();
}
