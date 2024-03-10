import 'package:flutter/material.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';

class boxBalanceScreen extends StatefulWidget {
  boxBalanceScreen({
    Key? key,
  }) : super(key: key);
  @override
  boxBalanceScreenState createState() => boxBalanceScreenState();
}

class boxBalanceScreenState extends State<boxBalanceScreen> {
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          " الصندوق",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                " رصيد الصندوق",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButon(
                text: ' 2000 ',
                Height: 60,
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
