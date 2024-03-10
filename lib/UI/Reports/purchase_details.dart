import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/Purchase_provider.dart';
import 'package:provider/provider.dart';

class PurchaseDetails extends StatefulWidget {
  String serialID;
  PurchaseDetails({Key? key, required this.serialID}) : super(key: key);
  @override
  PurchaseDetailsState createState() => PurchaseDetailsState();
}

class PurchaseDetailsState extends State<PurchaseDetails> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);
    await purchaseProvider.getPurchaseBillDtl(widget.serialID);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('تفاصيل المشتريات'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildAlasnafItems(context, index, provider),
                    itemCount: provider.purchaseState2.data == null
                        ? 0
                        : provider.purchaseState2.data!.length),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget buildAlasnafItems(
        BuildContext context, int index, PurchaseProvider provider) =>
    Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                      flex: 10,
                      child: Text(
                        provider.purchaseState2.data![index].itemNameArabic
                            .toString(),
                        style: const TextStyle(color: Colors.deepPurple),
                        textAlign: TextAlign.end,
                      )),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text('اسم الصنف '),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    provider.purchaseState2.data![index].netPrice
                        .toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.deepPurple,
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
                    provider.purchaseState2.data![index].totDiscDtl
                        .toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Expanded(
                    child: Text('الخصم '),
                  ),
                  Text(
                    provider.purchaseState2.data![index].quantity.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Text('الكميه '),
                ],
              ),
            ],
          ),
        ),
      ),
    );
