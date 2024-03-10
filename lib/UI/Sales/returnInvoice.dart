import 'package:flutter/material.dart';

class returnInvoiceScreen extends StatefulWidget {
  returnInvoiceScreen({
    Key? key,
  }) : super(key: key);
  @override
  returnInvoiceScreenState createState() => returnInvoiceScreenState();
}

class returnInvoiceScreenState extends State<returnInvoiceScreen> {
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
