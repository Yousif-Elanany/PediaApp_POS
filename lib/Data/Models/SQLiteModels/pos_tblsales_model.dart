class PosTblSalesModel {
  int? serialUser;
  int docType;
  int? docOn;
  int? docOnID;
  int payKind;
  int? docDocNo;
  int? dealerId;
  double docTotal;
  double discV;
  double discP;
  double totAdd;
  double totDisc;
  double totItemDisc;
  double docNetPrice;
  double docCash;
  String? refNo;
  int? userCreate;
  String? createDate;
  int? agentId;
  int? userMod;
  String? modDate;
  int? userPrint;
  String? printDate;
  int? printCount;
  String? docDate;
  int? docCase;
  String? note;
  int? serialID;
  int serialIdSqlite;
  double monyCash;
  int dealerIDSqlite;
  String dealerName;
  double qnt;
  String tafqeet;

  PosTblSalesModel({
      this.serialUser,
      this.docType=2,
      this.docOn,
      this.docOnID,
      this.payKind=1,
      this.docDocNo,
      this.dealerId,
      this.docTotal=0.0,
      this.discV=0.0,
      this.discP=0.0,
      this.totAdd=0.0,
      this.totDisc=0.0,
      this.totItemDisc=0.0,
      this.docNetPrice=0.00,
      this.docCash=0.0,
      this.refNo,
      this.userCreate,
      this.createDate,
      this.agentId,
      this.userMod,
      this.modDate,
      this.userPrint,
      this.printDate,
      this.printCount,
      this.docDate,
      this.docCase,
      this.note,
      this.serialID,
     required this.serialIdSqlite,
      this.monyCash=0.0,
  this.dealerIDSqlite = 0, this.dealerName="",this.qnt=0.0,this.tafqeet=""}
      );

   PosTblSalesModel.fromJson(Map<String, dynamic> json) :
        serialUser= json['SerialUser'],
        docType= json['DocType'],
        docOn= json['DocOn'],
        docOnID= json['DocOnID'],
        payKind= json['Pay_Kind'],
        docDocNo= json['Doc_DocNo'],
        dealerId= json['DealerId'],
        docTotal= json['DocTotal'],
        discV= json['DiscV'],
        discP= json['DiscP'],
        totAdd= json['TotAdd'],
        totDisc= json['TotDisc'],
        totItemDisc= json['TotItemDisc'],
        docNetPrice= json['DocNetPrice'],
        docCash= json['Doc_Cash'],
        refNo= json['RefNo'],
        userCreate= json['UserCreate'],
        createDate= json['CreateDate'],
        agentId= json['AgentId'],
        userMod= json['UserMod'],
        modDate= json['ModDate'],
        userPrint= json['UserPrint'],
        printDate= json['PrintDate'],
        printCount= json['PrintCount'],
        docDate= json['Doc_Date'],
        docCase= json['Doc_Case'],
        note= json['Note'],
        serialID= json['SerialID'],
        serialIdSqlite= 0,
        monyCash= json['MonyCash'],
         dealerIDSqlite= json['DealerIDSqlite'],
         dealerName= json['DealerName'],
         qnt = 0.0,
         tafqeet=""
  ;

  Map<String, Object?> toMap() {
    return {
    'SerialUser': serialUser,
    'DocType':docType,
    'DocOn': docOn,
    'DocOnID':docOnID,
    'PayKind':payKind,
    'DocDocNo':docDocNo,
    'DealerId':dealerId,
    'DocTotal':docTotal,
    'DiscV':discV,
    'DiscP':discP,
    'TotAdd':totAdd,
    'TotDisc':totDisc,
    'TotItemDisc':totItemDisc,
    'DocNetPrice':docNetPrice,
    'DocCash':docCash,
    'RefNo':refNo,
    'UserCreate':userCreate,
    'CreateDate':createDate,
    'AgentId':agentId,
    'UserMod':userMod,
    'ModDate':modDate,
    'UserPrint':userPrint,
    'PrintDate':printDate,
    'PrintCount':printCount,
    'DocDate':docDate,
    'DocCase':docCase,
    'Note':note,
    'SerialID':serialID,
    'SerialIdSqlite': serialIdSqlite,
    'MonyCash': monyCash,
      'DealerIDSqlite' : dealerIDSqlite,
      'DealerName':dealerName,
      'qnt':qnt,
      'tafqeet':tafqeet
    };
  }
}
