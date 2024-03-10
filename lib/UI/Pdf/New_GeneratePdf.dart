import 'dart:io';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tbldealers_model.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection hide Colors;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tblsales_dtl_model.dart';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tblsales_model.dart';
import 'package:pediaPOS/Globals/globalVariables.dart';
import 'package:pediaPOS/network/sqlite.dart';
//import 'package:printing/printing.dart';
import 'Pdf_api.dart';

PdfPageFormat page = PdfPageFormat.roll80;

Future<void> generatePdfAndPrinting(
    {required List<PosTblSalesDtlModel>? DataOfDtl,
    required List<PosTblSalesModel>? DataOfHdr}) async {
  final theme = ThemeData.withFont(
    base: Font.ttf(await rootBundle
        .load('assets/fonts/NotoNaskhArabic-VariableFont_wght.ttf')),
    bold: Font.ttf(await rootBundle
        .load('assets/fonts/NotoNaskhArabic-VariableFont_wght.ttf')),
  );
  PdfPageFormat page = PdfPageFormat.roll80;
  SQLiteDbProvider db = SQLiteDbProvider();

  PosTblDealersModel? userdata;
  if (DataOfHdr![0].dealerId == null || DataOfHdr[0].dealerId == 0) {
    Iterable<PosTblDealersModel> userdata = await db
        .getDealerSqliteDealerid("${DataOfHdr[0].dealerIDSqlite.toString()}");
  } else {
    Iterable<PosTblDealersModel> userdata =
        await db.getDealerById("${DataOfHdr[0].dealerId.toString()}");
  }

  final pdf = pw.Document(); // import 'package:pdf/widgets.dart' as pw
  pdf.addPage(
    pw.Page(
      theme: theme,
      pageFormat: page,
      build: (pw.Context context) {
        return pw.Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PdfColor.fromHex("#7C7B76"),
                ),
                child: Center(
                  child: Text(
                    "${CacheHelper.getData(key: "Company_Name")}",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("********"),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  " التاريخ             :${DateFormat('dd-MM-yyyy').format(
                    DateTime.now(),
                  )} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "${DateFormat('hh : mm : ss : aaa').format(DateTime.now())}             : الساعة  ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  " رقم القاتورة :     ${DataOfHdr![0].serialIdSqlite} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("*********"),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "الإجمالي",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "السعر",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "الكمية",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "    الصنف ",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                  itemBuilder: (Context context, int index) {
                    String subTotal =
                        "${DataOfDtl![index].netPrice * DataOfDtl![index].quantity}";

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl![index].netPrice.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl[index].itemPrice.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl![index].quantity.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(DataOfDtl![index].itemName,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl),
                        ),
                      ],
                    );
                  },
                  itemCount: DataOfDtl!.length),
              SizedBox(
                height: 5,
              ),
              Text("******"),
              SizedBox(
                height: 3,
              ),
              ListView.builder(
                  itemBuilder: (Context context, int index) {
                    num subtotal = 0;
                    for (int i = 0; i < DataOfDtl.length; i++) {
                      subtotal = subtotal + DataOfDtl[index].netPrice;
                    }
                    return Text(
                      "   الإجمالى للفاتورة :  ${subtotal} ",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    );
                  },
                  itemCount: 1),
              SizedBox(
                height: 3,
              ),
              Text("***********"),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "  أسم العميل  : :  ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "  رقم الهاتف    :    ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "             عنوان العميل \n ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("*******"),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "                    للتواصل مع الشركة الرجاء الإتصال على رقم     ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "  012365412369     ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    ),
  );
      
      

}

Future<File> generatePdfAndsendtowhatsapp(
    {required List<PosTblSalesDtlModel>? DataOfDtl,
    required List<PosTblSalesModel>? DataOfHdr}) async {
  final theme = ThemeData.withFont(
    base: Font.ttf(await rootBundle
        .load('assets/fonts/NotoNaskhArabic-VariableFont_wght.ttf')),
    bold: Font.ttf(await rootBundle
        .load('assets/fonts/NotoNaskhArabic-VariableFont_wght.ttf')),
  );
  PdfPageFormat page = PdfPageFormat.roll80;
  SQLiteDbProvider db = SQLiteDbProvider();

  PosTblDealersModel? userdata;
  if (DataOfHdr![0].dealerId == null || DataOfHdr[0].dealerId == 0) {
    Iterable<PosTblDealersModel> userdata = await db
        .getDealerSqliteDealerid("${DataOfHdr[0].dealerIDSqlite.toString()}");
  } else {
    Iterable<PosTblDealersModel> userdata =
        await db.getDealerById("${DataOfHdr[0].dealerId.toString()}");
  }

  final pdf = pw.Document(); // import 'package:pdf/widgets.dart' as pw
  pdf.addPage(
    pw.Page(
      theme: theme,
      pageFormat: page,
      build: (pw.Context context) {
        return pw.Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PdfColor.fromHex("#7C7B76"),
                ),
                child: Center(
                  child: Text(
                    "${CacheHelper.getData(key: "Company_Name")}",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("********"),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text( " التاريخ :            ${DateFormat('dd-MM-yyyy').format( DateTime.now())} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "${DateFormat('hh : mm : ss : aaa').format(DateTime.now())}             : الساعة  ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  " رقم القاتورة :          ${DataOfHdr![0].serialIdSqlite} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("*********"),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "الإجمالي",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "السعر",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "الكمية",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "    الصنف ",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                  itemBuilder: (Context context, int index) {
                    String subTotal =
                        "${DataOfDtl![index].netPrice * DataOfDtl![index].quantity}";

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl![index].netPrice.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl[index].itemPrice.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            DataOfDtl![index].quantity.toString(),
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(DataOfDtl![index].itemName,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl),
                        ),
                      ],
                    );
                  },
                  itemCount: DataOfDtl!.length),
              SizedBox(
                height: 5,
              ),
              Text("******"),
              SizedBox(
                height: 3,
              ),
              ListView.builder(
                  itemBuilder: (Context context, int index) {
                    num subtotal = 0;
                    for (int i = 0; i < DataOfDtl.length; i++) {
                      subtotal = subtotal + DataOfDtl[index].netPrice;
                    }
                    return Text(
                      "   الإجمالى للفاتورة :  ${subtotal} ",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    );
                  },
                  itemCount: 1),
              SizedBox(
                height: 3,
              ),
              Text("***********"),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "  أسم العميل  :   :  ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "  رقم الهاتف    :    ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "             عنوان العميل \n ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text("*******"),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "                    للتواصل مع الشركة الرجاء الإتصال على رقم     ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "  012365412369     ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    ),
  );

  return PdfApi.saveDocument(name: "Invoice.pdf", pdf: pdf);
}
