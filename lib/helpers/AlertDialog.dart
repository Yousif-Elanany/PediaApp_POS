import 'package:flutter/material.dart';
import 'package:pediaPOS/Globals/globalVariables.dart';
import 'package:pediaPOS/helpers/cons.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container();
            },
          );
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }
}

Widget SaveInvoiceDialog(
    {required BuildContext context,
      required Function() printEvent,
      required Function() whatsEvent,
      required String InvoiceNum}) {
  return AlertDialog(
    title: Text(
      textDirection: TextDirection.rtl,
      "   تم حفظ الفاتورة رقم  ${InvoiceNum}",
      style: const TextStyle(fontSize: 20),
    ),
    actions: <Widget>[
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text("طباعة"),
              onPressed: printEvent,
            ),
            TextButton(
                child: Text(" WhatsApp أرسال عبر "), onPressed: whatsEvent),
          ],
        ),
        TextButton(
          child: const Text("إنهاء"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ])
    ],
  );
}
