class PosPricesModel {
  int priceId;
  String priceDisc;
  bool saleDef;
  bool purDef;

  PosPricesModel({
    required this.priceId,
    required this.priceDisc,
    required this.saleDef,
    required this.purDef,
  });

  factory PosPricesModel.fromJson(Map<String, dynamic> json) {
    return PosPricesModel(
      priceId: json['PriceId'],
      priceDisc: json['PriceDisc'],
      saleDef: json['SaleDef'],
      purDef: json['PurDef'],
    );
  }
}
