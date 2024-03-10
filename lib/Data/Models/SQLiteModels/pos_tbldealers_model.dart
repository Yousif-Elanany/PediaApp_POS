class PosTblDealersModel {
  int dealerID;
  int storeId;
  String dealerCode;
  String dealerName;
  int glRefID;
  String glRefCode;
  String dealerCat;
  int salPriceID;
  int priceListID;
  bool allowCredit;
  double creditLimit;
  int agentID;
  int regionID;
  String mobile;
  String address;
  String segel;
  String taxCard;
  int dealerIDSqlite;

  PosTblDealersModel({
    required this.dealerID,
    required this.storeId,
    required this.dealerCode,
    required this.dealerName,
    required this.glRefID,
    required this.glRefCode,
    required this.dealerCat,
    required this.salPriceID,
    required this.priceListID,
    required this.allowCredit,
    required this.creditLimit,
    required this.agentID,
    required this.regionID,
    required this.mobile,
    required this.address,
    required this.segel,
    required this.taxCard,
    required this.dealerIDSqlite,
  });

   PosTblDealersModel.fromJson(Map<String, dynamic> json) :
      dealerID= json['DealerID'],
      storeId= json['StoreId'],
      dealerCode= json['DealerCode'],
      dealerName= json['DealerName'],
      glRefID= json['GlRefID'],
      glRefCode= json['GlRefCode'],
      dealerCat= json['DealerCat']??"",
      salPriceID= json['SalPriceID']??0,
      priceListID= json['PriceListID']??0,
      allowCredit= json['AllowCredit']==1? true:false,
      creditLimit= json['CreditLimit'] ==0 ?0.0:json['CreditLimit'],
         agentID= json['AgentID']??0,
         regionID= json['RegionID']??0,
         mobile= json['Mobile']??"",
         address= json['Address']??"",
         segel= json['Segel']??"",
         taxCard= json['TaxCard']??"",
         dealerIDSqlite= json['DealerIDSqlite'];


  Map<String, Object> toMap() {
    return {
      'DealerID':dealerID,
      'StoreId':storeId,
      'DealerCode' :dealerCode,
      'DealerName':dealerName,
      'GlRefID':glRefID,
      'GlRefCode':glRefCode,
      'DealerCat':dealerCat,
      'SalPriceID':salPriceID,
      'PriceListID':priceListID,
      'AllowCredit':allowCredit,
      'CreditLimit':creditLimit,
      'AgentID':agentID,
      'RegionID':regionID,
      'Mobile':mobile,
      'Address':address,
      'Segel' :segel,
      'TaxCard' :taxCard,
      'DealerIDSqlite': dealerIDSqlite,
    };}
}
