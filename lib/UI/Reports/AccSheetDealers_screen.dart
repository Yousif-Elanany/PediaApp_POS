import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/dealers_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:provider/provider.dart';

class AccSheetDealersScreen extends StatefulWidget {
  String fromDate;
  String toDate;
  int dealerType;
  String dealerCode;
  AccSheetDealersScreen(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.dealerType,
      required this.dealerCode})
      : super(key: key);
  @override
  AccSheetDealersScreenState createState() => AccSheetDealersScreenState();
}

class AccSheetDealersScreenState extends State<AccSheetDealersScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final dealersProvider =
        Provider.of<DealersProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUserprofile();
    await dealersProvider.getDealersACCSheet(
        userProvider.userState.data!.defCompany.toString(),
        widget.fromDate,
        widget.toDate,
        widget.dealerType,
        widget.dealerCode);
    getTotals(dealersProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DealersProvider>(
      builder: (context, dealersProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(pageName[widget.dealerType - 1]),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Spacer(),
                  Text(
                    'ما قبله',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildAccBefore(context, index, dealersProvider),
                    itemCount: dealersProvider.dealerAccState.data == null
                        ? 0
                        : dealersProvider.dealerAccState.data!.length),
              ),
              Expanded(
                flex: 15,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildFatoraItems(context, index, dealersProvider),
                    itemCount: dealersProvider.dealerAccState.data == null
                        ? 0
                        : dealersProvider.dealerAccState.data!.length),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            crValSTr,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          const Expanded(
                            child: Text('اجمالى دائن '),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            dbValStr,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          const Text('اجمالى مدين '),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          dealersProvider.dealerAccState.data != null
                              ? getBalance(
                                  dealersProvider,
                                  dealersProvider.dealerAccState.data!.length -
                                      1)
                              : '0.0',
                          style: const TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        const Expanded(
                          child: Text('اجمالي الرصيد '),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildFatoraItems(
      BuildContext context, int index, DealersProvider provider) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(
            horizontal: 2.0,
          ),
          color: const Color.fromARGB(255, 203, 233, 250),
          child: provider.dealerAccState.data![index].serialSal == null
              ? Row()
              : Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            provider.dealerAccState.data![index].docDate
                                .toString(),
                            style: const TextStyle(color: Colors.deepPurple),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          const Text('التاريخ '),
                          const Spacer(),
                          Text(
                            provider.dealerAccState.data![index].serialUser
                                .toString(),
                            style: const TextStyle(color: Colors.deepPurple),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          const Text('رقم المستند'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            getBalance(provider, index),
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          const Text('الرصيد '),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              provider.dealerAccState.data![index].crVal!
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.deepPurple,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 1.0,
                          ),
                          const Expanded(
                            child: Text('دائن '),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              provider.dealerAccState.data![index].dbVal!
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.deepPurple,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 1.0,
                          ),
                          const Text('مدين '),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

Widget buildAccBefore(
    BuildContext context, int index, DealersProvider provider) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        color: const Color.fromARGB(255, 180, 202, 166),
        child: provider.dealerAccState.data![index].serialSal != null
            ? Row()
            : Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          getBalance(provider, index),
                          style: const TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          width: 0.0,
                        ),
                        const Text('الرصيد '),
                        const SizedBox(
                          width: 0.0,
                        ),
                        Expanded(
                          child: Text(
                            provider.dealerAccState.data![index].befCrVal!
                                .toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Text('دائن '),
                        const SizedBox(
                          width: 0.0,
                        ),
                        Expanded(
                          child: Text(
                            provider.dealerAccState.data![index].befDbVal!
                                .toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Text('مدين '),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    ),
  );
}

List<String> dealerName = [
  'اسم العميل',
  'اسم المورد',
];
List<String> pageName = [
  'كشف حساب عميل',
  'كشف حساب مورد',
];

double crVal = 0.0;
double dbVal = 0.0;
String crValSTr = '0.0';
String dbValStr = '0.0';
getTotals(DealersProvider dealersProvider) {
  crVal = 0.0;
  dbVal = 0.0;
  for (var i = 0; i < dealersProvider.dealerAccState.data!.length; i++) {
    if (dealersProvider.dealerAccState.data![i].serialSal == null) {
      crVal += dealersProvider.dealerAccState.data![i].befCrVal!;
      dbVal += dealersProvider.dealerAccState.data![i].befDbVal!;
    } else {
      crVal += dealersProvider.dealerAccState.data![i].crVal!;
      dbVal += dealersProvider.dealerAccState.data![i].dbVal!;
    }
  }
  crValSTr = crVal.toStringAsFixed(2);
  dbValStr = dbVal.toStringAsFixed(2);
}

getBalance(DealersProvider dealersProvider, int index) {
  double balance = 0.0;
  if (index >= 0) {
    for (var i = 0; i <= index; i++) {
      if (dealersProvider.dealerAccState.data![i].serialSal == null) {
        balance += dealersProvider.dealerAccState.data![i].befCrVal! -
            dealersProvider.dealerAccState.data![i].befDbVal!;
      } else {
        balance += dealersProvider.dealerAccState.data![i].crVal! -
            dealersProvider.dealerAccState.data![i].dbVal!;
      }
    }
  }
  String balanceStr = balance.toStringAsFixed(2);
  if (balance > 0) {
    balanceStr = 'دائن ' + balance.toStringAsFixed(2);
  } else {
    balanceStr = 'مدين ' + ((balance) * -1).toStringAsFixed(2);
  }
  return balanceStr;
}
