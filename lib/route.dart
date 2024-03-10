import 'package:flutter/material.dart';
import 'package:pediaPOS/UI/Auth/login.dart';

import 'UI/home.dart';
import 'UI/homeNew.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case HomeNewScreen.route:
        return MaterialPageRoute(builder: (_) => const HomeNewScreen());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
