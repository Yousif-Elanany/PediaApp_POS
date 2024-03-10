class SCTblItemPricesModel {
  int itemId;
  int branshId;
  int priceId;
  double itemPrice1;
  double itemDisc1;
  double addPrice;

  SCTblItemPricesModel({
    required this.itemId,
    required this.branshId,
    required this.priceId,
    required this.itemPrice1,
    required this.itemDisc1,
    required this.addPrice,
  });

  factory SCTblItemPricesModel.fromJson(Map<String, dynamic> json) {
    return SCTblItemPricesModel(
      itemId: json['ItemId'],
      branshId: json['BranshId'],
      priceId: json['PriceId'],
      itemPrice1: json['ItemPrice1'] == null ? 0.0 : json['ItemPrice1'],
      itemDisc1: json['ItemDisc1'] == null ? 0.0 : json['ItemDisc1'],
      addPrice: json['AddPrice'] == null ? 0.0 : json['AddPrice'],
    );
  }
}
