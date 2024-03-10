import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tblsales_model.dart';
import 'package:pediaPOS/Globals/globalVariables.dart';

Widget SaveInvoiceDialog(BuildContext context) {
  return AlertDialog(
    title: Text(textDirection: TextDirection.rtl, "  تم حفظ الفاتورة رقم "),
    actions: <Widget>[
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text("طباعة"),
              onPressed: () {},
            ),
            TextButton(
              child: const Text(" WhatsApp أرسال عبر "),
              onPressed: () {},
            ),
          ],
        ),
        TextButton(
          child: const Text("إنهاء"),
          onPressed: () {},
        )
      ])
    ],
  );
}
