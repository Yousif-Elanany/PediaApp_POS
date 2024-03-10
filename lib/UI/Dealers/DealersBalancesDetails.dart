import 'package:flutter/material.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';
import 'package:pediaPOS/helpers/Custom_Search_TextFormField.dart';

class dealersBalances extends StatefulWidget {
  const dealersBalances({super.key});

  @override
  State<dealersBalances> createState() => _dealersBalancesState();
}

class _dealersBalancesState extends State<dealersBalances> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          " أرصدة العملاء",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " بحث باسم العميل او الموبيل",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                customSearchTextField(
                  hintText: 'قم بالبحث عن أرصدة العميل ',
                  mycontroller: searchController,
                  onsub: (String) {},
                  tybe: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      " نتيجة البحث",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: CustomButon(
                        text: ' اسم العميل من  البحث ',
                        Height: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        ':  أسم العميل',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: CustomButon(
                        text: ' رقم الموبيل من  البحث ',
                        Height: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        ' :  الموبيل ',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: CustomButon(
                        text: ' عنوان العميل من  البحث ',
                        Height: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        ' :   العنوان ',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: CustomButon(
                        text: ' رصيد العميل من  البحث ',
                        Height: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '  :  الرصيد ',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),
    );
  }
}
