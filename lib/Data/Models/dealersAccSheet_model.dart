class DealersACCSheetModel {
  String? serialSal;
  String? serialUser;
  double? befDbVal;
  double? befCrVal;
  double? dbVal;
  double? crVal;
  String? docDate;
  String? docName;
  String? docNameEn;
  String? note;
  String? docDateM;
  String? refNo;
  String? catename;
  String? docDateStr;
  String? monthYear;
  dynamic logoPhoto;
  int? checkCase;

  DealersACCSheetModel({
    this.serialSal,
    this.serialUser,
    this.befDbVal,
    this.befCrVal,
    this.dbVal,
    this.crVal,
    this.docDate,
    this.docName,
    this.docNameEn,
    this.note,
    this.docDateM,
    this.refNo,
    this.catename,
    this.docDateStr,
    this.monthYear,
    this.logoPhoto,
    this.checkCase,
  });

  factory DealersACCSheetModel.fromJson(Map<String, dynamic> json) {
    return DealersACCSheetModel(
      serialSal: json['SerialSal'],
      serialUser: json['SerialUser'],
      befDbVal: json['BefDbVal'],
      befCrVal: json['BefCrVal'],
      dbVal: json['DbVal'],
      crVal: json['CrVal'],
      docDate: json['Doc_Date'],
      docName: json['DocName'],
      docNameEn: json['DocNameEn'],
      note: json['Note'],
      docDateM: json['Doc_DateM'],
      refNo: json['RefNo'],
      catename: json['Catename'],
      docDateStr: json['DocDate'],
      monthYear: json['MonthYear'],
      logoPhoto: json['LogoPhoto'],
      checkCase: json['CheckCase'],
    );
  }
}
