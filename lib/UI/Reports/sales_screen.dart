import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/sales_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/reusable_components.dart';
import 'package:pediaPOS/UI/Reports/sales_details.dart';
import 'package:provider/provider.dart';

class SalesScreen extends StatefulWidget {
  String fromDate;
  String toDate;
  SalesScreen({Key? key, required this.fromDate, required this.toDate})
      : super(key: key);
  @override
  SalesScreenState createState() => SalesScreenState();
}

class SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final salesProvider = Provider.of<SalesProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUserprofile();
    await salesProvider.getSalesBills(
        userProvider.userState.data!.defCompany.toString(),
        widget.fromDate,
        widget.toDate);
    getTotals(salesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesProvider>(
      builder: (context, salesProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('المبيعات'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildFatoraItems(context, index, salesProvider),
                    itemCount: salesProvider.salesState.data == null
                        ? 0
                        : salesProvider.salesState.data!.length),
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
                            netStr,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Expanded(
                            child: Text(' اجمالى المبيعات '),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            discSTr,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Text('اجمالى خصم '),
                        ],
                      ),
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
      BuildContext context, int index, SalesProvider provider) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            SalesDetails(
              serialID: provider.salesState.data![index].serialID.toString(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(
            horizontal: 2.0,
          ),
          color: const Color.fromARGB(255, 203, 233, 250),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 10,
                        child: Text(
                          provider.salesState.data![index].dealerName
                              .toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 27, 24, 168)),
                          textAlign: TextAlign.right,
                        )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text('اسم العميل '),
                    const Spacer(),
                    Text(
                      provider.salesState.data![index].serialUser.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 24, 168)),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text('رقم الفاتورة'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      provider.salesState.data![index].docNetPrice.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 24, 168),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Expanded(
                      child: Text('صافى سعر '),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      provider.salesState.data![index].disc.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 24, 168),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Text('الخصم '),
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

double disc = 0.0;
double net = 0.0;
String discSTr = '0.0';
String netStr = '0.0';
getTotals(SalesProvider salesProvider) {
  disc = 0.0;
  net = 0.0;
  for (var i = 0; i < salesProvider.salesState.data!.length; i++) {
    disc += salesProvider.salesState.data![i].disc;
    net += salesProvider.salesState.data![i].docNetPrice;
  }
  discSTr = disc.toStringAsFixed(2);
  netStr = net.toStringAsFixed(2);
}
