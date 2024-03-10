import 'dart:convert';

class DealersBalanceModel {
  int dealerID_;
  String dealerCode;
  String dealerName;
  double befDbVal;
  double befCrVal;
  double dbVal;
  double crVal;
  double balance;
  String mobile;
  String address;
  DateTime transMaxDate;
  double sumLastVal;
  int follow;
  int flowDay;
  dynamic logoPhoto;
  String regionNameArabic;
  double creditLimit;
  int dealerType;

  DealersBalanceModel({
    required this.dealerID_,
    required this.dealerCode,
    required this.dealerName,
    required this.befDbVal,
    required this.befCrVal,
    required this.dbVal,
    required this.crVal,
    required this.balance,
    required this.mobile,
    required this.address,
    required this.transMaxDate,
    required this.sumLastVal,
    required this.follow,
    required this.flowDay,
    required this.logoPhoto,
    required this.regionNameArabic,
    required this.creditLimit,
    required this.dealerType,
  });

  factory DealersBalanceModel.fromJson(Map<String, dynamic> json) {
    return DealersBalanceModel(
        dealerID_: json['DealerID_'],
        dealerCode: json['DealerCode'],
        dealerName: json['DealerName'],
        befDbVal: json['BefDbVal'] == null ? 0.0 : json["BefDbVal"],
        befCrVal: json['BefCrVal'] == null ? 0.0 : json["BefCrVal"],
        dbVal: json['DbVal'] == null ? 0.0 : json["DbVal"],
        crVal: json['CrVal'] == null ? 0.0 : json["CrVal"],
        balance: json['Balance'] == null ? 0.0 : json["Balance"],
        mobile: json['Mobile'] == null ? "" : json["Mobile"],
        address: json['Address'] == null ? "" : json["Address"],
        transMaxDate: json['Trans_MaxDate'] == null
            ? DateTime.now()
            : DateTime.parse(json["Trans_MaxDate"]),
        sumLastVal: json['SumLastVal'] == null ? 0.0 : json["SumLastVal"],
        follow: json['Follow'],
        flowDay: json['FlowDay'] == null ? 0 : json["FlowDay"],
        logoPhoto: json['LogoPhoto'] == null
            ? ""
            : const Base64Decoder().convert(json["LogoPhoto"]),
        regionNameArabic:
            json['RegionNameArabic'] == null ? "" : json["RegionNameArabic"],
        creditLimit: json['CreditLimit'] == null ? 0.0 : json["CreditLimit"],
        dealerType: json['DealerType']);
  }
}
