class UserModel {
  int userID;
  bool userLang;
  int defBransh;
  int defCompany;
  String storNameArabic;
  String companyNameArabic;
  bool stockingAnnual;
  int groupID;
  bool groupActive;
  String groupCaption;
  bool active;
  String userName;
  String userPassword;
  String companyNameAr;
  String companyNameEn;
  String companyTel;
  String companyFax;
  Null empID;
  bool incomeState;
  String quantityDigit;
  String priceDigit;
  String oldDesign;
  bool prmAddClient;
  bool prmRptClientData;
  bool prmRptClientBalance;
  bool prmAddSales;
  bool prmAddReturnSales;
  bool prmChangeSalesPrice;
  bool prmDeferredSales;
  bool prmPayMoney;
  bool prmReceiveMoney;

  UserModel({
    required this.userID,
    required this.userLang,
    required this.defBransh,
    required this.defCompany,
    required this.storNameArabic,
    required this.companyNameArabic,
    required this.stockingAnnual,
    required this.groupID,
    required this.groupActive,
    required this.groupCaption,
    required this.active,
    required this.userName,
    required this.userPassword,
    required this.companyNameAr,
    required this.companyNameEn,
    required this.companyTel,
    required this.companyFax,
    required this.empID,
    required this.incomeState,
    required this.quantityDigit,
    required this.priceDigit,
    required this.oldDesign,
    required this.prmAddClient,
    required this.prmRptClientData,
    required this.prmRptClientBalance,
    required this.prmAddSales,
    required this.prmAddReturnSales,
    required this.prmChangeSalesPrice,
    required this.prmDeferredSales,
    required this.prmPayMoney,
    required this.prmReceiveMoney,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: json['User_ID'],
        userLang: json['UserLang'],
        defBransh: json['DefBransh'],
        defCompany: json['DefCompany'],
        storNameArabic: json['StorNameArabic'],
        companyNameArabic: json['CompanyNameArabic'],
        stockingAnnual: json['StockingAnnual'],
        groupID: json['Group_ID'],
        groupActive: json['Group_Active'],
        groupCaption: json['Group_Caption'],
        active: json['Active'],
        userName: json['User_Name'],
        userPassword: json['User_Password'],
        companyNameAr: json['CompanyNameAr'],
        companyNameEn: json['CompanyNameEn'],
        companyTel: json['CompanyTel'],
        companyFax: json['CompanyFax'],
        empID: json['EmpID'],
        incomeState: json['IncomeState'],
        quantityDigit: json['QuantityDigit'],
        priceDigit: json['PriceDigit'],
        oldDesign: json['OldDesign'],
        prmAddClient: json['PrmAddClient'] == "1" ? true : false,
        prmRptClientData: json['PrmRptClientData'] == "1" ? true : false,
        prmRptClientBalance: json['PrmRptClientBalance'] == "1" ? true : false,
        prmAddSales: json['PrmAddSales'] == "1" ? true : false,
        prmAddReturnSales: json['PrmAddReturnSales'] == "1" ? true : false,
        prmChangeSalesPrice: json['PrmChangeSalesPrice'] == "1" ? true : false,
        prmDeferredSales: json['PrmDeferredSales'] == "1" ? true : false,
        prmPayMoney: json['PrmPayMoney'] == "1" ? true : false,
        prmReceiveMoney: json['PrmReceiveMoney'] == "1" ? true : false);
  }
}
