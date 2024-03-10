class LookUpsModel {
  late String name;
  late int id;

LookUpsModel({required this.id,required this.name});

  factory LookUpsModel.fromJson(Map<String, dynamic> json){

    return LookUpsModel(id: json["id"],name: json["name"]);
  }
}