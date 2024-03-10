import 'dart:io';
import 'package:flutter/material.dart'
    hide Widget
    hide Container
    hide EdgeInsets
    hide TextStyle
    hide TextSpan
    hide RichText
    hide BoxDecoration
    hide Column
    hide BorderRadius
    hide Page
    hide CrossAxisAlignment
    hide Center
    hide TextDirection
    hide Stack
    hide Directionality
    hide TextDirection
    hide SizedBox
    hide Color
    hide Colors
    hide Alignment
    hide Text
    hide MainAxisAlignment
    hide Row
    hide Padding
    hide ListView
    hide Expanded
    hide Divider
    hide Theme
    hide ThemeData
    hide Image
    hide Align
    hide TableCell
    hide MemoryImage
    hide CircleAvatar
    hide Table
    hide TableRow
    hide TableCell
    hide TableBorder
    hide EdgeInsets;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'Pdf_api.dart';

class PdfGenerateApi {
  static Future generatePdf({required PdfPageFormat format}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return buildinvoicedesign(context);
        },
      ),
    );

    return pdf;
  }

  static Future<File> generate() async {
    final pdf = pw.Document();
    final ByteData notoNaskhArabic = await rootBundle
        .load("assets/fonts/NotoNaskhArabic-VariableFont_wght.ttf");
    final ttfFont = await Font.ttf(notoNaskhArabic);

    /// create pages
    pdf.addPage(
      Page(
        pageFormat: const PdfPageFormat(
            8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm,
            marginAll: 0.5 * PdfPageFormat.cm),
        build: (context) {
          return buildinvoicedesign(context);
        },
      ),
    );

    return await PdfApi.saveDocument(pdf: pdf, name: "Test");
  }

  static buildinvoicedesign(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: PdfColor.fromHex("#E6E7E8")),
              child: Center(
                child: Text(
                  "تقنية سيستمز",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("***************************************"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${DateFormat('dd-MM-yyyy').format(DateTime.now())}        :      الساعة ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${DateFormat('hh : mm : ss : aaa').format(DateTime.now())}       :      التاريخ  ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "            1              :      رقم الفاتورة ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("***************************"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الإجمالي",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "السعر",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "الكمية",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "      الصنف",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("***************************"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "800",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "800",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "1",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "هارد ديسك",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("***************************"),
            SizedBox(
              height: 10,
            ),
            Text(
              "  800        :      إجمالى الفاتورة ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("***************************"),
            SizedBox(
              height: 10,
            ),
            Text(
              "  أسم العميل        :      عميل    ؟؟؟؟؟؟  ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "  رقم الهاتف         :          01236542987  ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "    عنوان العميل          :    الفلل -  أبراج الزهور - قسم ثان   ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("********************************"),
            SizedBox(
              height: 10,
            ),
            Text(
              "  للتواصل مع الشركة الرجاء الإتصال على رقم     ",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "  012365412369     ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
