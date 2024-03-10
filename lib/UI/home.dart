import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pediaPOS/Data/Provider/home_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Reports/BoxBalance_screen.dart';
import 'package:pediaPOS/UI/Reports/DealersBalance_screen.dart';
import 'package:pediaPOS/UI/Reports/DealersSearch_screen.dart';
import 'package:pediaPOS/UI/Reports/purchase_screen.dart';
import 'package:pediaPOS/UI/Reports/sales_screen.dart';
import 'package:pediaPOS/UI/drawer.dart' as dr;
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/theme/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = "HomeScreen";

  @override
  HomeScreenState createState() => HomeScreenState();
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('MM-dd-yyyy');
// final String formatted = formatter.format(now);

final TextEditingController dateLastController = TextEditingController();
final TextEditingController dateBeginController = TextEditingController();

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final validationService = Provider.of<HomeProvider>(context, listen: false);
    final validationServiceUser =
        Provider.of<UserProvider>(context, listen: false);
    await validationServiceUser.getUserprofile();
    await validationService.getHomeData(
        formatter.format(DateTime.now()), formatter.format(DateTime.now()));
    values[0] = validationService.homeState.data!.salesTotal.toStringAsFixed(2);
    values[1] =
        validationService.homeState.data!.purchaseTotal.toStringAsFixed(2);
    values[2] = validationService.homeState.data!.boxCash.toString();
    values[3] = validationService.homeState.data!.dealersDepts.toString();
    dateBeginController.text = formatter.format(DateTime.now());
    dateLastController.text = formatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(CacheHelper.getData(key: "Company_Name")),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              final validationService =
                                  Provider.of<HomeProvider>(context,
                                      listen: false);
                              await validationService.getHomeData(
                                  dateBeginController.text,
                                  dateLastController.text);
                              values[0] = validationService
                                  .homeState.data!.salesTotal
                                  .toStringAsFixed(2);
                              values[1] = validationService
                                  .homeState.data!.purchaseTotal
                                  .toStringAsFixed(2);
                              values[2] = validationService
                                  .homeState.data!.boxCash
                                  .toString();
                              values[3] = validationService
                                  .homeState.data!.dealersDepts
                                  .toString();
                            },
                            child: const Text(
                              'تحديث',
                              style: TextStyle(fontSize: 20.0),
                            )),
                      )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                            controller: dateLastController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                              labelText: 'إلى تاريخ',
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                            ),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('2000-10-10'),
                                      lastDate: DateTime.parse('2100-10-10'))
                                  .then((value) {
                                dateLastController.text =
                                    formatter.format(value!);
                              });
                            }),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                            readOnly: true,
                            controller: dateBeginController,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                              labelText: 'من تاريخ',
                              labelStyle:
                                  TextStyle(fontStyle: FontStyle.italic),
                            ),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('2000-10-10'),
                                      lastDate: DateTime.parse('2100-10-10'))
                                  .then((value) {
                                dateBeginController.text =
                                    formatter.format(value!);
                              });
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                          (index) => buildGridProduct(context,
                              title: titlePages[index],
                              icons: icons[index],
                              screens: screens[index],
                              values: values[index])),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: Theme(
              data: Theme.of(context).copyWith(
             //   backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.black54),
                canvasColor: AppColor.liteBlack.withOpacity(.5),
              ),
              child: const dr. NavigationDrawer()),
        );
      },
    );
  }

  Widget buildGridProduct(
    context, {
    String? title,
    required String icons,
    int? screens,
    String? values,
  }) =>
      InkWell(
        onTap: ({
          int index = 0,
        }) {
          switch (screens) {
            case 0:
              AppNavigator.navigateTo(
                  context,
                  SalesScreen(
                    fromDate: dateBeginController.text,
                    toDate: dateLastController.text,
                  ));
              break;

            case 1:
              AppNavigator.navigateTo(
                  context,
                  PurchaseScreen(
                    fromDate: dateBeginController.text,
                    toDate: dateLastController.text,
                  ));
              break;
            case 2:
              AppNavigator.navigateTo(
                  context,
                  BoxBalanceScreen(
                      fromDate: dateBeginController.text,
                      toDate: dateLastController.text));
              break;
            case 3:
              AppNavigator.navigateTo(
                  context,
                  DealersBalanceScreen(
                    fromDate: dateBeginController.text,
                    toDate: dateLastController.text,
                  ));
              break;
            case 4:
              AppNavigator.navigateTo(
                  context,
                  DealersSearchScreen(
                    fromDate: dateBeginController.text,
                    toDate: dateLastController.text,
                    dealerType: 1,
                  ));
              break;
            case 5:
              AppNavigator.navigateTo(
                  context,
                  DealersSearchScreen(
                    fromDate: dateBeginController.text,
                    toDate: dateLastController.text,
                    dealerType: 2,
                  ));
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          '$values',
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
              ],
            ),
          ),
        ),
      );

  List<String> values = [
    '0.0',
    '0.0',
    '',
    '',
    '',
    '',
  ];

  List<String> titlePages = [
    'مبيعات',
    'مشتريات',
    'اجمالى خزينه',
    'مديونيات العملاء',
    'كشف حساب عميل',
    'كشف حساب مورد',
  ];

  List<String> icons = [
    'assets/images/Sales.png',
    'assets/images/Purchase.png',
    'assets/images/Box.png',
    'assets/images/Debets.png',
    'assets/images/AccSheet.png',
    'assets/images/AccSheet2.png',
  ];

  List<int> screens = [
    0,
    1,
    2,
    3,
    4,
    5,
  ];
}
