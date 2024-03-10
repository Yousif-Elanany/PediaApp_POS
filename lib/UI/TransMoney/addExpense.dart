import 'package:flutter/material.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';
import 'package:pediaPOS/helpers/Custom_TextFormField.dart';

class addExpenseScreen extends StatefulWidget {
  addExpenseScreen({
    Key? key,
  }) : super(key: key);
  @override
  addExpenseScreenState createState() => addExpenseScreenState();
}

enum Place { cash, credit }

class addExpenseScreenState extends State<addExpenseScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}
  Place? _place;
  TextEditingController priceController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  void handleSelection(Place? value) {
    setState(() {
      _place = value;
    });
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          " المصروفات",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      activeColor: Colors.white,
                      value: Place.cash,
                      groupValue: _place,
                      onChanged: handleSelection,
                    ),
                    const Text(
                      'نقدي',
                      style: TextStyle(fontSize: 20),
                    ),
                    Radio(
                        activeColor: Colors.white,
                        value: Place.credit,
                        groupValue: _place,
                        onChanged: handleSelection),
                    const Text(
                      ' بطاقة ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  controller: priceController,
                  hintText: " المبلغ  ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  controller: reportController,
                  hintText: " البيان ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButon(
                  text: ' حفظ ',
                  Height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
