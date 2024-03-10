import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/cupertino.dart';
import 'package:pediaPOS/Data/API_Methods/user_data.dart';
import 'package:pediaPOS/Data/Models/companyData_model.dart';
import 'package:pediaPOS/Data/Models/userData_Model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';

class UserProvider extends ChangeNotifier {
  late ProviderGeneralState<UserModel> userState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<CompanyModel> companyState =
      ProviderGeneralState(waiting: true);

  UserData userData = UserData();
  bool isLoading = false;

  listen() {
    notifyListeners();
  }

  getUserprofile() async {
    UserModel userModel;
    userModel = await userData.getUserProfile();
    userState = ProviderGeneralState(hasData: true, data: userModel);

    notifyListeners();
    return 200;
  }

  validateEmail(String value) {
    value = value.trim().toString();
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.replaceAll(" ", "").isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
      return false;
    }
    return true;
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  loginUser({userName, password}) async {
    var response = await userData.loginUser(userName, password);
    return response;
  }

  connectAPI(conn) async {
    // conn =
    //     'Mrl3QwU3VUeD+bJ/KcyYnXq0hfZScXIyHGn7GEQit2zcJT/x8At+YMGw2VvQHeZPLoe+KpHUHd8wb/dLCGf+lA==';
    // conn = decryptAES(conn);
    var response = await userData.connectAPI(conn);
    return response;
  }

  mobRegister(conn) async {
    var response = await userData.mobRegister(conn);
    return response;
  }

  getCompanyData() async {
    CompanyModel companyModel;
    companyModel = await userData.getCompanyData();
    companyState = ProviderGeneralState(data: companyModel, hasData: true);
    notifyListeners();
  }
}

decryptAES(encrypted) {
  var key = enc.Key.fromBase64('yE9tgqNxWcYDTSPNM+EGQw==');
  var iv = enc.IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');
  var encrypter = enc.Encrypter(enc.AES(key));

  var decrypted =
      encrypter.decrypt(enc.Encrypted.fromBase64(encrypted), iv: iv);
  return decrypted;
}
