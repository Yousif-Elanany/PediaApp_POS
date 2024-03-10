import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/dealers_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:provider/provider.dart';

class BoxBalanceScreen extends StatefulWidget {
  String fromDate;
  String toDate;
  BoxBalanceScreen({Key? key, required this.fromDate, required this.toDate})
      : super(key: key);
  @override
  DealersBalanceScreenState createState() => DealersBalanceScreenState();
}

class DealersBalanceScreenState extends State<BoxBalanceScreen> {
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
    await dealersProvider.getDealersBalance(
        userProvider.userState.data!.defCompany.toString(),
        widget.fromDate,
        widget.toDate,
        3);
    getTotals(dealersProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DealersProvider>(
      builder: (context, dealersProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('أرصدة الخزائن'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildDealersBalance(context, index, dealersProvider),
                    itemCount: dealersProvider.dealersBalanceState.data == null
                        ? 0
                        : dealersProvider.dealersBalanceState.data!.length),
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
                            balanceStr,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 27, 24, 168),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('اجمالى الأرصدة '),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDealersBalance(
      BuildContext context, int index, DealersProvider dealersProvider) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.grey[100],
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(
            horizontal: 0.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      dealersProvider.dealersBalanceState.data![index].balance
                          .toStringAsFixed(2),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 24, 168)),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text('الرصيد '),
                    const Spacer(),
                    Text(
                      dealersProvider
                          .dealersBalanceState.data![index].dealerName
                          .toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 24, 168)),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text('اسم الخزينة '),
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

double balance = 0.0;
String balanceStr = '0.0';
getTotals(DealersProvider dealersProvider) {
  balance = 0.0;
  for (var i = 0; i < dealersProvider.dealersBalanceState.data!.length; i++) {
    balance += dealersProvider.dealersBalanceState.data![i].balance;
  }
  balanceStr = balance.toStringAsFixed(2);
}
