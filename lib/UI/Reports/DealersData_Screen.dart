import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/dealers_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Reports/AccSheetDealers_screen.dart';
import 'package:provider/provider.dart';

class DealersDataScreen extends StatefulWidget {
  static const route = "DealersDataScreen";
  String dealerName;
  int dealerType;
  String companyID;
  String fromDate;
  String toDate;
  DealersDataScreen(
      {Key? key,
      required this.dealerName,
      required this.companyID,
      required this.dealerType,
      required this.fromDate,
      required this.toDate})
      : super(key: key);
  @override
  DealersDataScreenState createState() => DealersDataScreenState();
}

class DealersDataScreenState extends State<DealersDataScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final dealersProvider =
        Provider.of<DealersProvider>(context, listen: false);
    await dealersProvider.getDealersData(
        widget.companyID, widget.dealerType, widget.dealerName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DealersProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(''),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildDealerData(
                          context,
                          index,
                          provider,
                          widget.fromDate,
                          widget.toDate,
                          widget.dealerType),
                      itemCount: provider.dealersDataState.data == null
                          ? 0
                          : provider.dealersDataState.data!.length),
                ),
              ],
            ));
      },
    );
  }
}

Widget buildDealerData(BuildContext context, int index,
    DealersProvider provider, String dFrom, String dTo, int dealerType) {
  return InkWell(
    onTap: () {
      AppNavigator.navigateTo(
          context,
          AccSheetDealersScreen(
            fromDate: dFrom,
            toDate: dTo,
            dealerType: dealerType,
            dealerCode: provider.dealersDataState.data![index].dealerCode!,
          ));
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
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Text(
                  provider.dealersDataState.data![index].mobile.toString(),
                  style: const TextStyle(color: Colors.deepPurple),
                )),
            const SizedBox(
              width: 5.0,
            ),
            const Text('رقم الموبايل'),
            const Spacer(),
            Expanded(
                flex: 8,
                child: Text(
                  provider.dealersDataState.data![index].dealerName.toString(),
                  style: const TextStyle(color: Colors.deepPurple),
                )),
            const SizedBox(
              width: 5.0,
            ),
            Text(dealerType == 1 ? 'اسم العميل' : 'اسم المورد'),
          ],
        ),
      ),
    ),
  );
}
