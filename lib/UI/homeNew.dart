import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/home_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Dealers/DealersPage.dart';
import 'package:pediaPOS/UI/Dealers/addDealer.dart';
import 'package:pediaPOS/UI/Sales/editInvoice.dart';
import 'package:pediaPOS/UI/Sales/returnInvoice.dart';
import 'package:pediaPOS/UI/TransMoney/addExpense.dart';
import 'package:pediaPOS/UI/TransMoney/addTrans.dart';
import 'package:pediaPOS/UI/TransMoney/boxBalance.dart';
import 'package:pediaPOS/UI/drawer.dart' as dr;
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../network/sqlite.dart';
import 'Sales/addInvoice.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeNewScreen extends StatefulWidget {
  const HomeNewScreen({Key? key}) : super(key: key);
  static const route = "HomeNewScreen";

  @override
  HomeNewScreenState createState() => HomeNewScreenState();
}

class HomeNewScreenState extends State<HomeNewScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUserprofile();
    // final LocalData = Provider.of<SQLiteDbProvider>(context, listen: false);
    // await LocalData.fillDataFromLocal("100", "1001", "1");
    setState(() {
      if (user.userState.data!.prmAddSales) {
        titlePages.add('المبيعات');
        icons.add('assets/images/Sales.png');
        screens.add(0);
      }
      if (user.userState.data!.prmAddClient) {
        titlePages.add('العملاء');
        icons.add('assets/images/Purchase.png');
        screens.add(1);
      }
      if (true) {
        titlePages.add('الصندوق');
        icons.add('assets/images/Box.png');
        screens.add(2);
      }
      if (user.userState.data!.prmPayMoney) {
        titlePages.add('المصروفات');
        icons.add('assets/images/Debets.png');
        screens.add(3);
      }
      if (user.userState.data!.prmAddReturnSales) {
        titlePages.add('مرتجع مبيعات');
        icons.add('assets/images/AccSheet.png');
        screens.add(4);
      }
      if (true) {
        titlePages.add('تعديل فاتورة بيع');
        icons.add('assets/images/AccSheet2.png');
        screens.add(5);
      }
      if (user.userState.data!.prmReceiveMoney) {
        titlePages.add('سند قبض');
        icons.add('assets/images/AccSheet2.png');
        screens.add(6);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(CacheHelper.getData(key: "Company_Name")),
            actions: <Widget>[
              PopupMenuButton(
                  icon: const Icon(Icons.account_tree_outlined),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("تحديث الأصناف والعملاء"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("تحديث الأرصدة والأسعار"),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text("تحديث كل البيانات"),
                      ),
                    ];
                  },
                  onSelected: (value) async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      final user =
                          Provider.of<UserProvider>(context, listen: false);
                      await user.getUserprofile();
                      final localData =
                          Provider.of<SQLiteDbProvider>(context, listen: false);
                      if (value == 0) {
                        try {
                          await localData.fillPosTblDealers(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          await localData.fillSCTblItems(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          await localData.fillUnits(
                              user.userState.data!.defCompany.toString());
                          await localData.fillBarcodes(
                              user.userState.data!.defCompany.toString());
                          await localData.fillSCTblItemUnits(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          Alert(
                            context: context,
                            title: "تم بنجاح",
                            desc: "تم تحديث البيانات بنجاح",
                            image: Image.asset("assets/images/success.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        } catch (e) {
                          Alert(
                            context: context,
                            title: "خطأ",
                            desc: e.toString(),
                            image: Image.asset("assets/images/error.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        }
                      } else if (value == 1) {
                        try {
                          await localData.fillPosPrices(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          await localData.fillSCTblItemPrices(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          await localData.fillAgent();
                          await localData.fillSCTblItemStocks(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          Alert(
                            context: context,
                            title: "تم بنجاح",
                            desc: "تم تحديث البيانات بنجاح",
                            image: Image.asset("assets/images/success.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        } catch (e) {
                          Alert(
                            context: context,
                            title: "خطأ",
                            desc: e.toString(),
                            image: Image.asset("assets/images/error.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        }
                      } else if (value == 2) {
                        try {
                          await localData.fillDataFromLocal(
                              user.userState.data!.defCompany.toString(),
                              user.userState.data!.defBransh.toString(),
                              user.userState.data!.userID.toString());
                          Alert(
                            context: context,
                            title: "تم بنجاح",
                            desc: "تم تحديث البيانات بنجاح",
                            image: Image.asset("assets/images/success.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        } catch (e) {
                          Alert(
                            context: context,
                            title: "خطأ",
                            desc: e.toString(),
                            image: Image.asset("assets/images/error.png"),
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ).show();
                        }
                      }
                    } else {
                      Alert(
                        context: context,
                        title: "خطأ",
                        desc: "من فضلك تأكد من الإتصال بالإنترنت",
                        image: Image.asset("assets/images/error.png"),
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ).show();
                    }
                  }),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white60,
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1,
                      children: List.generate(
                        icons.length,
                        (index) => buildGridProduct(
                          context,
                          title: titlePages[index],
                          icons: icons[index],
                          screens: screens[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.black54),
                canvasColor: AppColor.liteBlack.withOpacity(.5),
              ),
              child: const dr.NavigationDrawer()),
        );
      },
    );
  }

  Widget buildGridProduct(
    context, {
    String? title,
    required String icons,
    int? screens,
  }) =>
      InkWell(
        onTap: ({
          int index = 0,
        }) {
          switch (screens) {
            case 0:
              AppNavigator.navigateOff(context, AddInvoiceScreen());
              break;

            case 1:
              AppNavigator.navigateTo(context, DealersPage());
              break;
            case 2:
              AppNavigator.navigateTo(context, boxBalanceScreen());
              break;
            case 3:
              AppNavigator.navigateTo(context, addExpenseScreen());
              break;
            case 4:
              AppNavigator.navigateTo(context, returnInvoiceScreen());
              break;
            case 5:
              AppNavigator.navigateTo(context, editInvoiceScreen());
              break;
            case 6:
              AppNavigator.navigateTo(context, addTransScreen());
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            color: Colors.grey[200],
            margin: const EdgeInsets.symmetric(
              horizontal: 0.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        icons,
                        width: 80,
                        height: 80,
                      ),
                    )),
                const SizedBox(
                  height: 5.0,
                ),
                Center(
                  child: Text(
                    '$title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  List<String> titlePages = <String>[];
  List<String> icons = <String>[];
  List<int> screens = <int>[];
}
