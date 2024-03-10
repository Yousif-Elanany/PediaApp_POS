import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/sales_provider.dart';
import 'package:provider/provider.dart';

class SalesDetails extends StatefulWidget {
  String serialID;
  SalesDetails({Key? key, required this.serialID}) : super(key: key);
  @override
  SalesDetailsState createState() => SalesDetailsState();
}

class SalesDetailsState extends State<SalesDetails> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final salesProvider = Provider.of<SalesProvider>(context, listen: false);
    await salesProvider.getSalesBillDtl(widget.serialID);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('تفاصيل المبيعات'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildAlasnafItems(context, index, provider),
                    itemCount: provider.salesState2.data == null
                        ? 0
                        : provider.salesState2.data!.length),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget buildAlasnafItems(
        BuildContext context, int index, SalesProvider provider) =>
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
                        provider.salesState2.data![index].itemNameArabic
                            .toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 27, 24, 168)),
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
                    provider.salesState2.data![index].netPrice
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
                    provider.salesState2.data![index].totDiscDtl.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 27, 24, 168),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Expanded(
                    child: Text('الخصم '),
                  ),
                  Text(
                    provider.salesState2.data![index].quantity.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 27, 24, 168),
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
