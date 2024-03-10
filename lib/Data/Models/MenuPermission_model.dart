class MenuPermissionmodel {
  String keyFrm;
  int menuLock;

  MenuPermissionmodel({
    required this.keyFrm,
    required this.menuLock,
  });

  factory MenuPermissionmodel.fromJson(Map<String, dynamic> json) {
    return MenuPermissionmodel(
        keyFrm: json['Key_Frm'] == null ? "" : json["Key_Frm"],
        menuLock: json['MenuLuck'] == null ? 0 : json["MenuLuck"]);
  }
}
