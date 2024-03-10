import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/Purchase_provider.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/reusable_components.dart';
import 'package:pediaPOS/UI/Reports/purchase_details.dart';
import 'package:provider/provider.dart';

class PurchaseScreen extends StatefulWidget {
  String fromDate;
  String toDate;
  PurchaseScreen({Key? key, required this.fromDate, required this.toDate})
      : super(key: key);
  @override
  PurchaseScreenState createState() => PurchaseScreenState();
}

class PurchaseScreenState extends State<PurchaseScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUserprofile();
    await purchaseProvider.getPurchaseBills(
        userProvider.userState.data!.defCompany.toString(),
        widget.fromDate,
        widget.toDate);
    getTotals(purchaseProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseProvider>(
      builder: (context, purchaseProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('المشتريات'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildFatoraItems(context, index, purchaseProvider),
                    itemCount: purchaseProvider.purchaseState.data == null
                        ? 0
                        : purchaseProvider.purchaseState.data!.length),
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
                              color: Color.fromARGB(255, 27, 24, 168),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Expanded(
                            child: Text(' اجمالى المشتريات '),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            discSTr,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 27, 24, 168),
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
      BuildContext context, int index, PurchaseProvider provider) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            PurchaseDetails(
              serialID: provider.purchaseState.data![index].serialID.toString(),
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
                          provider.purchaseState.data![index].dealerName
                              .toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 27, 24, 168)),
                          textAlign: TextAlign.right,
                        )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text('اسم المورد '),
                    const Spacer(),
                    Text(
                      provider.purchaseState.data![index].serialUser.toString(),
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
                      provider.purchaseState.data![index].docNetPrice
                          .toStringAsFixed(2),
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
                      provider.purchaseState.data![index].disc
                          .toStringAsFixed(2),
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
getTotals(PurchaseProvider purchaseProvider) {
  disc = 0.0;
  net = 0.0;
  for (var i = 0; i < purchaseProvider.purchaseState.data!.length; i++) {
    disc += purchaseProvider.purchaseState.data![i].disc;
    net += purchaseProvider.purchaseState.data![i].docNetPrice;
  }
  discSTr = disc.toStringAsFixed(2);
  netStr = net.toStringAsFixed(2);
}
