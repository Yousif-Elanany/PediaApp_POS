import 'package:flutter/material.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';
import 'package:pediaPOS/helpers/Custom_TextFormField.dart';

class addTransScreen extends StatefulWidget {
  addTransScreen({
    Key? key,
  }) : super(key: key);
  @override
  addTransScreenState createState() => addTransScreenState();
}

enum Place { cash, check, credit }

class addTransScreenState extends State<addTransScreen> {
  var formKey = GlobalKey<FormState>();
  Place? _place;
  bool _cashSelect = false;
  bool _creditselect = false;
  bool _chechSelect = false;

  TextEditingController sheekNumcontroller = TextEditingController();
  TextEditingController clientnameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController invoiceNumController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  void handleSelection(Place? value) {
    setState(() {
      _place = value;
      _creditselect = value == Place.credit;
      _cashSelect = value == Place.cash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          " سند قبض",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                        value: Place.check,
                        groupValue: _place,
                        onChanged: handleSelection),
                    const Text(
                      'شيك',
                      style: TextStyle(fontSize: 20),
                    ),
                    Radio(
                        activeColor: Colors.white,
                        value: Place.credit,
                        groupValue: _place,
                        onChanged: handleSelection),
                    const Text(
                      ' بطاقة',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                (_cashSelect)
                    ? Container()
                    : CustomFormTextField(
                        controller: sheekNumcontroller,
                        hintText: _creditselect ? " رقم البطاقة" : "رقم الشيك ",
                        textdirection: TextDirection.ltr,
                      ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: clientnameController,
                  hintText: "أسم العميل ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: priceController,
                  hintText: " المبلغ ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: invoiceNumController,
                  hintText: " رقم الفاتورة ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: commentController,
                  hintText: " ملاحظــات",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButon(
                  Height: 50,
                  text: " حفظ ",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
