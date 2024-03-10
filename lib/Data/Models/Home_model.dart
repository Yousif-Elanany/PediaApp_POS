class HomeModel {
  double salesTotal;
  double purchaseTotal;
  String dealersDepts;
  String boxCash;
  String clientACC;
  String supplierACC;

  HomeModel({
    required this.salesTotal,
    required this.purchaseTotal,
    required this.dealersDepts,
    required this.boxCash,
    required this.clientACC,
    required this.supplierACC,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        salesTotal: json['salesTotal'] == null ? 0.0 : json["salesTotal"],
        purchaseTotal:
            json['purchaseTotal'] == null ? 0.0 : json["purchaseTotal"],
        dealersDepts: json['dealersDepts'] == null ? "" : json["dealersDepts"],
        boxCash: json['boxCash'] == null ? "" : json["boxCash"],
        clientACC: json['clientACC'] == null ? "" : json["clientACC"],
        supplierACC: json['supplierACC'] == null ? "" : json["supplierACC"]);
  }
}
