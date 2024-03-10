class SCTblItemStocksModel {
  int itemID;
  int branshId;
  double currentStock;
  String expDate;
  String batchNo;

  SCTblItemStocksModel({
    required this.itemID,
    required this.branshId,
    required this.currentStock,
    required this.expDate,
    required this.batchNo,
  });

  factory SCTblItemStocksModel.fromJson(Map<String, dynamic> json) {
    return SCTblItemStocksModel(
      itemID: json['ItemID'] ?? 0,
      branshId: json['BranshId'],
      currentStock: json['CurrentStock'],
      expDate: json['ExpDate'] ?? "",
      batchNo: json['BatchNo'] ?? "",
    );
  }
}
