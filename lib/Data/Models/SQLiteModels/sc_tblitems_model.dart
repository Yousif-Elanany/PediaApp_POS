class SCTblItemsModel {
  int itemID;
  String itemCode;
  String itemName;
  int catID;
  String catName;
  int itemType;
  int devSalUnit;
  String unitName;
  bool expDate;
  double startCost;
  double avregCost;
  double lastCost;
  double mesureCost;
  bool creditYN;
  int grpPriceID;
  int  devStockUnit;
  int  itemSerial;
  int  vatCase;
  double tax1;
  double tax2;
  double tax3;

  static final columns = ["itemID", "itemCode", "itemName", "catID", "catName","itemType","devSalUnit","unitName","expDate"
    ,"startCost","avregCost","lastCost","mesureCost","creditYN","grpPriceID"];
  SCTblItemsModel({
    required this.itemID,
    required this.itemCode,
    required this.itemName,
    required this.catID,
    required this.catName,
    required this.itemType,
    required this.devSalUnit,
    required this.unitName,
    required this.expDate,
    required this.startCost,
    required this.avregCost,
    required this.lastCost,
    required this.mesureCost,
    required this.creditYN,
    required this.grpPriceID,
    required this.devStockUnit,
    required this.itemSerial,
    required this.vatCase,
    required this.tax1,
    required this.tax2,
    required this.tax3,
  });

  factory SCTblItemsModel.fromJson(Map<String, dynamic> json) {
    return SCTblItemsModel(
      itemID: json['ItemID'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      catID: json['CatID'] ?? 0,
      catName: json['CatName'],
      itemType: json['ItemType'],
      devSalUnit: json['DevSalUnit'],
      unitName: json['UnitName'],
      expDate: json['ExpDate'] == "1" ? true : false,
      startCost: (json['StartCost'] as num).toDouble(),
      avregCost: (json['AvregCost'] as num).toDouble(),
      lastCost: (json['LastCost'] as num).toDouble(),
      mesureCost: (json['MesureCost'] as num).toDouble(),
      creditYN: json['CreditYN']== "1" ? true : false,
      grpPriceID: json['GrpPriceID'],
      devStockUnit: json['DevStockUnit'],
      itemSerial: json['ItemSerial'],
      vatCase: json['VatCase'],
      tax1: (json['Tax1'] as num).toDouble(),
      tax2: (json['Tax2'] as num).toDouble(),
      tax3: (json['Tax3'] as num).toDouble(),
    );
  }

  SCTblItemsModel.fromMap(Map<String, dynamic> json):
  itemID= json['ItemID'],
  itemCode= json['ItemCode'],
  itemName= json['ItemName'],
  catID= json['CatID']??0,
  catName= json['CatName']??"",
  itemType= json['ItemType'],
  devSalUnit= json['DevSalUnit'],
  unitName= json['UnitName'],
  expDate= json['ExpDate']==1? true : false,
  startCost=json['StartCost'] ==0?0.0:(json['StartCost'] as num).toDouble(),
  avregCost= json['AvregCost'] ==0?0.0:(json['AvregCost'] as num).toDouble(),
  lastCost= json['LastCost'] ==0?0.0:(json['LastCost'] as num).toDouble(),
  mesureCost= json['MesureCost'] ==0?0.0:(json['MesureCost'] as num).toDouble(),
  creditYN= json['CreditYN']==1? true:false,
  grpPriceID= json['GrpPriceID']??0,
  devStockUnit= json['DevStockUnit']??0,
  itemSerial= json['ItemSerial']??0,
  vatCase= json['VatCase'],
  tax1= (json['Tax1'] as num).toDouble(),
  tax2= (json['Tax2'] as num).toDouble(),
  tax3= (json['Tax3'] as num).toDouble();

  Map<String, Object> toMap() {
    return {
    'ItemID': itemID ,
    'ItemCode': itemCode,
    'ItemName': itemName,
    'CatID': catID,
    'CatName':catName,
    'ItemType': itemType,
    'DevSalUnit':devSalUnit,
    'UnitName':unitName,
    'ExpDate':expDate,
    'StartCost':startCost,
    'AvregCost': avregCost,
    'LastCost':lastCost,
    'MesureCost':mesureCost,
    'CreditYN':creditYN,
    'GrpPriceID':grpPriceID,
      'DevStockUnit':devStockUnit,
      'ItemSerial': itemSerial,
      'VatCase': vatCase,
      'Tax1': tax1,
      'Tax2': tax2,
      'Tax3': tax3,
  };
  }
}
