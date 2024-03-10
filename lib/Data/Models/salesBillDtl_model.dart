class SalesDtlModel {
  String itemNameArabic;
  double quantity;
  double totDiscDtl;
  double netPrice;

  SalesDtlModel({
    required this.itemNameArabic,
    required this.quantity,
    required this.totDiscDtl,
    required this.netPrice,
  });

  factory SalesDtlModel.fromJson(Map<String, dynamic> json) {
    return SalesDtlModel(
        itemNameArabic: json['ItemNameArabic'],
        quantity: json['Quantity'] == null ? 0.0 : json["Quantity"],
        totDiscDtl: json['TotDiscDtl'] == null ? 0.0 : json["TotDiscDtl"],
        netPrice: json['NetPrice'] == null ? 0.0 : json["NetPrice"]);
  }
}
