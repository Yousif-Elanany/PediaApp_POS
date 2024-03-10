import 'package:pediaPOS/Data/Models/companyData_model.dart';
import 'package:pediaPOS/Data/Models/userData_Model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/network/serviceshandler.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  late ProviderGeneralState<UserModel> userState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<CompanyModel> companyState =
      ProviderGeneralState(waiting: true);

  getUserProfile() async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var userID = CacheHelper.getData(key: "User_ID");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_getUserData&Params=[%20{%20%22NUserID%22:%20$userID%20}%20]&Constr=$conn");
    UserModel userModel = UserModel.fromJson(response[0]);
    return userModel;
  }
  loginUser(userName, password) async {
    try {
      var conn = CacheHelper.getData(key: "Conn_str");
      var response = await ServicesHandler().getService(
          urlSuffix:
              'select?proName=Permation_LoginUser&Params=[{"TUserName":"${userName.toString()}","TPassword":"${password.toString()}"}]&Constr=$conn');
      if (response.toString() == "[]") {
        return 100;
      } else {
        await CacheHelper.saveData(
            key: "User_Password",
            value: response[0]["User_Password"].toString());
        await CacheHelper.saveData(
            key: "User_ID", value: response[0]["User_ID"]);
        return 200;
      }
    } catch (ex) {
      return 100;
    }
  }

  connectAPI(connStr) async {
    try {
      var response = await ServicesHandler().getService(
          urlSuffix:
              "select?proName=API_testConn&Params=[%20{%20%22NID%22:%201}%20]&Constr=$connStr");
      if (response.toString() == "[]" || response == null) {
        return 100;
      } else {
        return 200;
      }
    } catch (ex) {
      return 100;
    }
  }

  mobRegister(connStr) async {
    try {
      var response = await ServicesHandler().getService(
          urlSuffix:
              "select?proName=API_Mob_register&Params=[%20{%20%22NID%22:%201}%20]&Constr=$connStr");
      // print(response[0]["ver2"]);
      if (response.toString() == "[]" ||
          response == null ||
          response[0]["ver2"] == "rBd/9xaeS3A=") {
        return 100;
      } else if (response[0]["ver2"] == "kfEejek0YXg=") {
        return 200;
      } else {
        return 100;
      }
    } catch (ex) {
      return 100;
    }
  }

  getCompanyData() async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var companyID = CacheHelper.getData(key: "User_ID");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_getCompanyData&Params=[%20{%20%22NCompanyID%22:%20$companyID%20}%20]&Constr=$conn");
    CompanyModel companyModel = CompanyModel.fromJson(response[0]);
    return companyModel;
  }
}
