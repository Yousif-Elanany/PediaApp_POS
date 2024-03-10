class SalesModel {
  String serialUser;
  String dealerName;
  double disc;
  double docNetPrice;
  int serialID;

  SalesModel({
    required this.serialUser,
    required this.dealerName,
    required this.disc,
    required this.docNetPrice,
    required this.serialID,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
        serialUser: json['SerialUser'],
        dealerName: json['DealerName'],
        disc: json['DiscV'] == null ? 0.0 : json["DiscV"],
        docNetPrice: json['DocNetPrice'] == null ? 0.0 : json["DocNetPrice"],
        serialID: json['SerialID']);
  }
}
