class PosTblSalesDtlModel {
  int serialId;
 int recId;
  int serialIdSqlite;
  String codeDtl;
  int branchIdDtl;
  String barCode;
  int itemId;
  double quantity;
  double stockQuantity;
  int unitId;
  double convParm;
  double itemCost;
  double itemPrice;
  double itemCprice;
  double totalCost;
  double discPDtl;
  double discvDtl;
  double totDiscDtl;
  double totAddDtl;
  double netPrice;
  double invDistDisc;
  double invDistTotDisc;
  double invDistTotAdd;
  int priceID;
  String salesDtlNote;
  double discPDtl2;
  double discPDtl3;
  double totAddDtl2;
  double totAddDtl3;
  double totalPrice;
  double taxDtl1;
  double taxDtl2;
  double taxDtl3;
  double taxDtlval1;
  double taxDtlval2;
  double taxDtlval3;
  String itemName;
  String unitName;

  PosTblSalesDtlModel({
    required this.serialId,
    required this.recId,
    required this.serialIdSqlite,
    required this.codeDtl,
    required this.branchIdDtl,
    required this.barCode,
    required this.itemId,
    required this.quantity,
    required this.stockQuantity,
    required this.unitId,
    required this.convParm,
    required this.itemCost,
    required this.itemPrice,
    required this.itemCprice,
    required this.totalCost,
    required this.discPDtl,
    required this.discvDtl,
    required this.totDiscDtl,
    required this.totAddDtl,
    required this.netPrice,
    required this.invDistDisc,
    required this.invDistTotDisc,
    required this.invDistTotAdd,
    required this.priceID,
    required this.salesDtlNote,
    required this.discPDtl2,
    required this.discPDtl3,
    required this.totAddDtl2,
    required this.totAddDtl3,
    required this.totalPrice,
    required this.taxDtl1,
    required this.taxDtl2,
    required this.taxDtl3,
    required this.taxDtlval1,
    required this.taxDtlval2,
    required this.taxDtlval3,
    required this.itemName,
    required this.unitName,
  });

  PosTblSalesDtlModel.fromJson(Map<String, dynamic> json) :
      recId=0,
  serialId= json['serialId'],
  serialIdSqlite= json['serialIdSqlite'],
  codeDtl= json['codeDtl'],
  branchIdDtl= json['branchIdDtl'],
  barCode= json['barCode'],
  itemId= json['itemId'],
  quantity= json['quantity'],
        stockQuantity= 0.0,
  unitId= json['unitId'],
  convParm= json['convParm'],
  itemCost= json['itemCost'],
  itemPrice= json['itemPrice'],
  itemCprice= json['itemCprice'],
  totalCost= json['totalCost'],
  discPDtl= json['discPDtl'],
  discvDtl= json['discvDtl'],
  totDiscDtl= json['totDiscDtl'],
  totAddDtl= json['totAddDtl'],
  netPrice= json['netPrice'],
  invDistDisc= json['invDistDisc'],
  invDistTotDisc= json['invDistTotDisc'],
  invDistTotAdd= json['invDistTotAdd'],
  priceID= json['priceID'],
  salesDtlNote= json['salesDtlNote'],
  discPDtl2= json['discPDtl2'],
  discPDtl3= json['discPDtl3'],
  totAddDtl2= json['totAddDtl2'],
  totAddDtl3= json['totAddDtl3'],
  totalPrice= json['totalPrice'],
  taxDtl1= json['taxDtl1'],
  taxDtl2= json['taxDtl2'],
  taxDtl3= json['taxDtl3'],
  taxDtlval1= json['taxDtlval1'],
  taxDtlval2= json['taxDtlval2'],
  taxDtlval3= json['taxDtlval3'],
  itemName= json['itemName'],
  unitName= json['unitName'];

  Map<String, Object?> toMap()
  {
    return
    {
    'RecId':recId,
    'serialId':serialId,
    'serialIdSqlite':serialIdSqlite,
    'codeDtl':codeDtl,
    'branchIdDtl':branchIdDtl,
    'barCode':barCode,
    'itemId':itemId,
    'quantity':quantity,
    'stockQuantity':stockQuantity,
    'unitId':unitId,
    'convParm':convParm,
    'itemCost':itemCost,
    'itemPrice':itemPrice,
    'itemCprice':itemCprice,
    'totalCost':totalCost,
    'discPDtl':discPDtl,
    'discvDtl':discvDtl,
    'totDiscDtl':totDiscDtl,
    'totAddDtl':totAddDtl,
    'netPrice':netPrice,
    'invDistDisc':invDistDisc,
    'invDistTotDisc':invDistTotDisc,
    'invDistTotAdd':invDistTotAdd,
    'priceID':priceID,
    'salesDtlNote':salesDtlNote,
    'discPDtl2':discPDtl2,
    'discPDtl3':discPDtl3,
    'totAddDtl2':totAddDtl2,
    'totAddDtl3':totAddDtl3,
    'totalPrice':totalPrice,
    'taxDtl1':taxDtl1,
    'taxDtl2':taxDtl2,
    'taxDtl3':taxDtl3,
    'taxDtlval1':taxDtlval1,
    'taxDtlval2':taxDtlval2,
    'taxDtlval3':taxDtlval3,
    'itemName':itemName,
    'unitName':unitName
    };
  }
}
