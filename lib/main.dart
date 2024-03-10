import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/dealers_provider.dart';
import 'package:pediaPOS/Data/Provider/Purchase_provider.dart';
import 'package:pediaPOS/Data/Provider/sales_provider.dart';
import 'package:pediaPOS/Data/Provider/home_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/UI/splash.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/route.dart';
import 'package:provider/provider.dart';
import 'network/sqlite.dart';
   
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SQLiteDbProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SalesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PurchaseProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DealersProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Account Pedia POS',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const login(),
          home: const Splash(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
