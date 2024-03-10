import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tblsales_dtl_model.dart';
import 'package:pediaPOS/Data/Models/SQLiteModels/pos_tblsales_model.dart';
import 'package:pediaPOS/Data/Models/agent_model.dart';
import 'package:pediaPOS/Globals/globalVariables.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';
import 'package:pediaPOS/helpers/Custom_TextFormField.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/network/sqlite.dart';

class addDealerScreen extends StatefulWidget {
  addDealerScreen({
    Key? key,
  }) : super(key: key);
  @override
  addDealerScreenState createState() => addDealerScreenState();
}

class addDealerScreenState extends State<addDealerScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var agents = await SQLiteDbProvider.db.getAgent();
    var agent = agents[0];
    var x = await SQLiteDbProvider.db.getDealerSqlId();
    if (GlobalVariables.hdr.isEmpty) {
      PosTblSalesModel hdr1 = PosTblSalesModel(
          serialIdSqlite: x,
          agentId: agent.agentlID,
          createDate: DateTime.now().toString(),
          printCount: 0,
          serialID: 0,
          docDate: DateTime.now().toString(),
          docCase: 0,
          docOn: 0,
          docOnID: 0,
          refNo: x.toString());
      GlobalVariables.hdr.add(hdr1);
    }
  }

  var formKey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CommercialRegisterController = TextEditingController();
  TextEditingController TaxNumberController = TextEditingController();
  SQLiteDbProvider db = SQLiteDbProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          " أضافة عميل جديد ",
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "  بيانات العميل ",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CustomFormTextField(
                  controller: NameController,
                  hintText: "أسم العميل ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: PhoneController,
                  hintText: "رقم الموبايل ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: AddressController,
                  hintText: " العنوان ",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: CommercialRegisterController,
                  hintText: "السجل التجاري",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: TaxNumberController,
                  hintText: "الرقم الضريبي",
                  textdirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButon(
                  Height: 50,
                  text: " حفظ ",
                  onTap: () async {
                    var agents = await SQLiteDbProvider.db.getAgent();
                    if (agents.isNotEmpty) {
                      print("Yes ..... Not emtpy");
                    }
                    AgentModel agent = agents[0];
                    print("${agent.regionID}");

                    print("Done");
                    //(DealerID INTEGER ,StoreId INTEGER,DealerCode TEXT,DealerName TEXT,
                    //GlRefID INTEGER,GlRefCode TEXT,DealerCat TEXT,SalPriceID INTEGER,PriceListID INTEGER,
                    //AllowCredit INTEGER,CreditLimit NUMERIC,AgentID INTEGER,RegionID
                    //INTEGER,Mobile Text,Address Text,Segel Text,TaxCard Text,DealerIDSqlite INTEGER
                    int res = await db.insertDataInTabl('''
                       INSERT INTO Pos_TblDealers 
                       (StoreId,AgentID,RegionID,DealerIDSqlite,DealerName,Mobile,Address,Segel,TaxCard)
                       VALUES("${agents[0].branchID}","${agents[0].agentlID}","${agents[0].regionID}","1","${NameController.text}","${PhoneController.text}","${AddressController.text}","${CommercialRegisterController.text}","${TaxNumberController.text}") ''');
                    print(" res ===== ${res}");
                    //  print(response);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButon(
                  Height: 50,
                  text: " read ",
                  onTap: () async {
                    List<Map> resp =
                    await db.readTableData('SELECT * FROM Pos_TblDealers');
                    print(resp);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
