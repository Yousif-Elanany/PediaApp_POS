import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class receiptScreen extends StatefulWidget {
  const receiptScreen({super.key});

  @override
  State<receiptScreen> createState() => _receiptScreenState();
}

class _receiptScreenState extends State<receiptScreen> {
  late Uint8List imagefile;

  @override
  Widget build(BuildContext context) {
    //shotwidget() {
    // screenshotController.capture().then((Uint8List? image) {
    //Capture Done
    //  setState(() {
    //    _imageFile = image;
    //    print("done");
    // });
    // }).catchError((onError) {
    //    print(onError);
    //  });
    //}

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[600],
          centerTitle: true,
          title: const Text(
            "فاتورة المبيعات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey),
                    child: const Center(
                      child: Text(
                        "تقنية سيستمز",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("***************************************"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${DateFormat('dd-MM-yyyy').format(DateTime.now())}        :      الساعة ",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${DateFormat('hh : mm : ss : aaa').format(DateTime.now())}       :      التاريخ  ",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "            1              :      رقم الفاتورة ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("***************************"),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الإجمالي",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "السعر",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "الكمية",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "      الصنف",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("***************************"),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "800",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "800",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "1",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "هارد ديسك",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("***************************"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "  800        :      إجمالى الفاتورة ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("***************************"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "  أسم العميل        :      عميل    ؟؟؟؟؟؟  ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "  رقم الهاتف         :          01236542987  ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "    عنوان العميل          :    الفلل -  أبراج الزهور - قسم ثان   ",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("********************************"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "  للتواصل مع الشركة الرجاء الإتصال على رقم     ",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "  012365412369     ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
