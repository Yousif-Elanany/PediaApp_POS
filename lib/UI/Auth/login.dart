import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Models/userData_Model.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/custom_button.dart';
import 'package:pediaPOS/Data/components/custom_text_field.dart';
import 'package:pediaPOS/Data/components/displaysnackbar.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../Data/Models/agent_model.dart';
import '../../network/sqlite.dart';
import '../homeNew.dart';

class LoginScreen extends StatelessWidget {
  static const route = "LoginScreen";
  final TextEditingController controllerUserName = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 100.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/login.png"),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: textField(
                    controller: controllerUserName,
                    icon: Icons.mobile_screen_share,
                    hintText: "اسم المستخدم"),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: textField(
                    controller: controllerPassword,
                    hintText: "كلمة السر",
                    icon: Icons.password,
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: customElevatedButtonWithIcon(context,
                    title: "تسجيل الدخول", function: () async {
                  final validationService =
                      Provider.of<UserProvider>(context, listen: false);
                  var response = await validationService.loginUser(
                      userName: controllerUserName.text,
                      password: controllerPassword.text);
                  switch (response) {
                    case 100:
                      displaySnackBar(context, "يرجي مراجعة البيانات ");
                      break;
                    case 200:
                      validationService.listen();
                      UserModel response2 =
                          await validationService.userData.getUserProfile();
                      final localData =
                          Provider.of<SQLiteDbProvider>(context, listen: false);
                      await localData.fillAgent();
                      await CacheHelper.saveData(
                          key: "Company_Name", value: response2.companyNameAr);
                      Navigator.pushReplacementNamed(
                          context, HomeNewScreen.route);
                      break;
                  }
                  return response;
                },
                    height: 45,
                    color: AppColor.fillColor,
                    backGroundColor: AppColor.liteBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
