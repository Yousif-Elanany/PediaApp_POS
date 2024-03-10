import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Auth/connection_screen.dart';
import 'package:pediaPOS/UI/Auth/login.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:provider/provider.dart';

import 'homeNew.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> switchFirstPage(context) async {
    String? conn = await CacheHelper.getData(key: "Conn_str");
    if (conn == null) {
      AppNavigator.navigateTo(context, ConnectionScreen());
    } else {
      final validationService =
          Provider.of<UserProvider>(context, listen: false);
      var response = await validationService.connectAPI(conn);
      switch (response) {
        case 100:
          AppNavigator.navigateTo(context, ConnectionScreen());
          break;
        case 200:
          validationService.listen();
          int? userID = await CacheHelper.getData(key: "User_ID");
          if (userID == null) {
            AppNavigator.navigateTo(context, LoginScreen());
          } else {
            Navigator.pushReplacementNamed(context, HomeNewScreen.route);
          }
          break;
      }
    }
  }

  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return switchFirstPage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Image.asset(
          'assets/images/interface.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
