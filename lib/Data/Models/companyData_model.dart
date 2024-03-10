class CompanyModel {
  int? companyID;
  String? companyCode;
  String? companyNameArabic;
  String? companyNameEnglish;
  String? address;
  String? tel;
  String? fax;
  String? companyMail;
  String? contactName;
  int? empID;
  String? currencyAr;
  String? currencyEn;
  bool? stockingAnnual;
  String? modDate;
  String? currencySymAr;
  String? currencySymEn;
  dynamic logophoto;
  bool? incomeState;
  String? currencyAllAr;
  String? currencySymAllAr;
  String? currencyAllEn;
  String? currencySymAllEn;
  String? decimalNum;
  String? countryKey;
  String? taxType;
  String? taxID;
  String? taxpayerActivityCode;
  int? issuerbranchID;
  String? issuerGovernate;
  String? issuerRegionCity;
  String? issuerStreet;
  String? issuerBuildingNumber;
  String? issuerPostalCode;
  String? issuerFloor;
  String? issuerRoom;
  String? issuerCountry;

  CompanyModel(
      {this.companyID,
      this.companyCode,
      this.companyNameArabic,
      this.companyNameEnglish,
      this.address,
      this.tel,
      this.fax,
      this.companyMail,
      this.contactName,
      this.empID,
      this.currencyAr,
      this.currencyEn,
      this.stockingAnnual,
      this.modDate,
      this.currencySymAr,
      this.currencySymEn,
      this.logophoto,
      this.incomeState,
      this.currencyAllAr,
      this.currencySymAllAr,
      this.currencyAllEn,
      this.currencySymAllEn,
      this.decimalNum,
      this.countryKey,
      this.taxType,
      this.taxID,
      this.taxpayerActivityCode,
      this.issuerbranchID,
      this.issuerGovernate,
      this.issuerRegionCity,
      this.issuerStreet,
      this.issuerBuildingNumber,
      this.issuerPostalCode,
      this.issuerFloor,
      this.issuerRoom,
      this.issuerCountry});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        companyID: json['CompanyID'],
        companyCode: json['CompanyCode'],
        companyNameArabic: json['CompanyNameArabic'],
        companyNameEnglish: json['CompanyNameEnglish'],
        address: json['Address'],
        tel: json['Tel'],
        fax: json['Fax'],
        companyMail: json['CompanyMail'],
        contactName: json['ContactName'],
        empID: json['EmpID'],
        currencyAr: json['CurrencyAr'],
        currencyEn: json['CurrencyEn'],
        stockingAnnual: json['StockingAnnual'],
        modDate: json['ModDate'],
        currencySymAr: json['CurrencySymAr'],
        currencySymEn: json['CurrencySymEn'],
        logophoto: json['Logophoto'],
        incomeState: json['IncomeState'],
        currencyAllAr: json['CurrencyAllAr'],
        currencySymAllAr: json['CurrencySymAllAr'],
        currencyAllEn: json['CurrencyAllEn'],
        currencySymAllEn: json['CurrencySymAllEn'],
        decimalNum: json['DecimalNum'],
        countryKey: json['CountryKey'],
        taxType: json['taxType'],
        taxID: json['TaxID'],
        taxpayerActivityCode: json['taxpayerActivityCode'],
        issuerbranchID: json['IssuerbranchID'],
        issuerGovernate: json['IssuerGovernate'],
        issuerRegionCity: json['IssuerRegionCity'],
        issuerStreet: json['IssuerStreet'],
        issuerBuildingNumber: json['IssuerBuildingNumber'],
        issuerPostalCode: json['IssuerPostalCode'],
        issuerFloor: json['IssuerFloor'],
        issuerRoom: json['IssuerRoom'],
        issuerCountry: json['IssuerCountry']);
  }
}
