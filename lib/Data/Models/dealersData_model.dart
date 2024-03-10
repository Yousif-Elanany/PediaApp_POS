class DealersDataModel {
  int? dealerID;
  String? dealerCode;
  String? dealerName;
  String? keyPerson;
  String? country;
  String? area;
  String? address;
  String? tel1;
  String? tel2;
  String? fax;
  String? mobile;
  String? eMail;

  DealersDataModel(
      {this.dealerID,
      this.dealerCode,
      this.dealerName,
      this.keyPerson,
      this.country,
      this.area,
      this.address,
      this.tel1,
      this.tel2,
      this.fax,
      this.mobile,
      this.eMail});

  factory DealersDataModel.fromJson(Map<String, dynamic> json) {
    return DealersDataModel(
        dealerID: json['DealerID'],
        dealerCode: json['DealerCode'],
        dealerName: json['DealerName'],
        keyPerson: json['KeyPerson'],
        country: json['Country'],
        area: json['Area'],
        address: json['Address'],
        tel1: json['Tel1'],
        tel2: json['Tel2'],
        fax: json['Fax'],
        mobile: json['Mobile'],
        eMail: json['E_mail']);
  }
}
