import 'package:flutter/material.dart';

class editInvoiceScreen extends StatefulWidget {
  editInvoiceScreen({
    Key? key,
  }) : super(key: key);
  @override
  editInvoiceScreenState createState() => editInvoiceScreenState();
}

class editInvoiceScreenState extends State<editInvoiceScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
