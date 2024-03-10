class MGTblDocsModel {
  int docId;
  String docName;
  String docSymbol;
  int docStart;
  int autoSerial;
  int docType;
  int dirType;
  int rsvStock;
  int stock;
  int stockWay;
  int underOut;
  int cost;
  int copyN;
  int pricePlaneDoc;

  MGTblDocsModel({
    required this.docId,
    required this.docName,
    required this.docSymbol,
    required this.docStart,
    required this.autoSerial,
    required this.docType,
    required this.dirType,
    required this.rsvStock,
    required this.stock,
    required this.stockWay,
    required this.underOut,
    required this.cost,
    required this.copyN,
    required this.pricePlaneDoc,
  });

  factory MGTblDocsModel.fromJson(Map<String, dynamic> json) {
    return MGTblDocsModel(
      docId: json['DocId'],
      docName: json['DocName'],
      docSymbol: json['DocSymbol'],
      docStart: json['DocStart'],
      autoSerial: json['AutoSerial'],
      docType: json['DocType'],
      dirType: json['DirType'],
      rsvStock: json['RsvStock'],
      stock: json['Stock'],
      stockWay: json['StockWay'],
      underOut: json['UnderOut'],
      cost: json['Cost'],
      copyN: json['CopyN'],
      pricePlaneDoc: json['PricePlane_Doc'],
    );
  }
}
