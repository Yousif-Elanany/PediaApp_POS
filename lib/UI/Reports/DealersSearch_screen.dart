import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Reports/DealersData_Screen.dart';
import 'package:pediaPOS/UI/home.dart';
import 'package:provider/provider.dart';

class DealersSearchScreen extends StatefulWidget {
  String fromDate;
  String toDate;
  int dealerType;
  DealersSearchScreen(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.dealerType})
      : super(key: key);
  @override
  DealersSearchScreenState createState() => DealersSearchScreenState();
}

class DealersSearchScreenState extends State<DealersSearchScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    dateBeginController.text = widget.fromDate;
    dateLastController.text = widget.toDate;
  }

  var formKey = GlobalKey<FormState>();

  var dateBeginController = TextEditingController();
  var dateLastController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.end,
                  enabled: true,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "برجاء ادخل الاسم او جزء منه ";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                    labelText:
                        widget.dealerType == 1 ? 'اسم العميل' : 'اسم المورد',
                    labelStyle: const TextStyle(fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: .5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: .5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          readOnly: true,
                          controller: dateLastController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'إلى تاريخ',
                            labelStyle: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.parse('2000-10-10'),
                                    lastDate: DateTime.parse('2100-10-10'))
                                .then((value) {
                              dateLastController.text =
                                  formatter.format(value!);
                            });
                          }),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextFormField(
                          readOnly: true,
                          controller: dateBeginController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'من تاريخ',
                            labelStyle: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.parse('2000-10-10'),
                                    lastDate: DateTime.parse('2100-10-10'))
                                .then((value) {
                              dateBeginController.text =
                                  formatter.format(value!);
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppNavigator.navigateTo(
                              context,
                              DealersDataScreen(
                                dealerName: nameController.text,
                                companyID: userProvider
                                    .userState.data!.defCompany
                                    .toString(),
                                dealerType: widget.dealerType,
                                fromDate: dateBeginController.text,
                                toDate: dateLastController.text,
                              ));
                        }
                      },
                      child: const Text(
                        'عرض',
                        style: TextStyle(fontSize: 20.0),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
