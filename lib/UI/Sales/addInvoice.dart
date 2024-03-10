import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pediaPOS/UI/Invoice_Design_Model/InvoiceDesign.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Pdf/Pdf_api.dart';
import 'package:pediaPOS/UI/Pdf/generate_Pdf_api.dart';
import 'package:pediaPOS/UI/PrinterPage/Blu-Print-Page.dart';
//import 'package:pediaPOS/UI/PrinterPage/Blu-Print-Page.dart';
import 'package:pediaPOS/UI/homeNew.dart';
import 'package:pediaPOS/helpers/AlertDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tafqit/tafqit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../Data/API_Methods/Sales_data.dart';
import '../../Data/Models/SQLiteModels/fill_search_model.dart';
import '../../Data/Models/SQLiteModels/pos_tblbarcodedtl.dart';
import '../../Data/Models/SQLiteModels/pos_tbldealers_model.dart';
import '../../Data/Models/SQLiteModels/pos_tblsales_dtl_model.dart';
import '../../Data/Models/SQLiteModels/pos_tblsales_model.dart';
import '../../Data/Models/agent_model.dart';
import '../../Data/Provider/user_provider.dart';
import '../../Globals/GlobalVariables.dart';
import '../../network/cache_helper.dart';
import '../../network/sqlite.dart';
import '../../Data/Models/SQLiteModels/sc_tblitems_model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:pdf/widgets.dart ' as pw;

import '../Pdf/New_GeneratePdf.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({
    super.key,
  });
  @override
  AddInvoiceScreenState createState() => AddInvoiceScreenState();
}

enum PayKind { cash, agel, visa }

class AddInvoiceScreenState extends State<AddInvoiceScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var userID = CacheHelper.getData(key: "User_ID");
    var agents = await SQLiteDbProvider.db.getAgent();
    agent = agents[0];
    var x = await SQLiteDbProvider.db.getMaxCode();
    if (GlobalVariables.hdr.isEmpty) {
      PosTblSalesModel hdr1 = PosTblSalesModel(
          serialIdSqlite: x,
          agentId: agent.agentlID,
          userCreate: userID,
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
    controlerDealerName.text = GlobalVariables.hdr[0].dealerName;
  }
  bool _cashSelect = false;
  bool _creditselect = false;
  bool _chechSelect = false;
  PayKind? _payKind ;

  handleSelection(PayKind? value) {
    setState(() {
      _payKind=value;
//       GlobalVariables.hdr[0].payKind ;     
//  if (_payKind==PayKind.cash)
// {
// setState(() {
//    GlobalVariables.hdr[0].payKind=1;
//    print(GlobalVariables.hdr[0].payKind);
// });

//  } else if (_payKind==PayKind.agel)
//   {
// setState(() {

//     GlobalVariables.hdr[0].payKind=2;
//   print(GlobalVariables.hdr[0].payKind);
// });
//    }
//  else if (_payKind==PayKind.visa)
//   {
//   setState(() {

//         GlobalVariables.hdr[0].payKind=5;
//   print(GlobalVariables.hdr[0].payKind);
    
//   });

//   }
  });

 }
  
  var Api = SalesData();
  var formKey = GlobalKey<FormState>();
  var tafqit = Tafqit();
  late AgentModel agent;
  bool showDealerSearch = false;
  // String CountryCode = "+20";
  // String ClientNum = "1009500968";
  // String SendMessage = " Hi Iam A message From Taknaya Systems";
  @override
  Widget build(BuildContext context) {
        _payKind ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("المبيعات"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: goBack,
        ),
        actions: <Widget>[
          PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("الغاء الفاتورة"),
                  ),
                ];
              },
              onSelected: (value) async {
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  if (value == 0) {
                    setState(() {
                      var userID = GlobalVariables.hdr[0].userCreate;
                      var agent = GlobalVariables.hdr[0].agentId;
                      var x = GlobalVariables.hdr[0].serialIdSqlite;
                      GlobalVariables.hdr.clear();
                      GlobalVariables.dtl.clear();
                      if (GlobalVariables.hdr.isEmpty) {
                        PosTblSalesModel hdr1 = PosTblSalesModel(
                            serialIdSqlite: x,
                            agentId: agent,
                            userCreate: userID,
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
                      controlerDealerName.text =
                          GlobalVariables.hdr[0].dealerName;
                    });
                  }
                }
              }),
        ],
      ),
      body: Form(
          key: formKey,
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   getGestureHdr(
                     const Icon(
                       Icons.attach_money,
                      size: 50,
                    ),
                   ),
                
                  Expanded(
                    child: TypeAheadField<SCTblItemsModel>(
                        hideOnEmpty: true,
                        hideOnSelect: true,
                        hideWithKeyboard: true,
                        controller: controlerItemName,
                        suggestionsCallback: (pattern) async {
                          if (pattern.length > 1) {
                            return await SQLiteDbProvider.db
                                .getItemByName(pattern);
                          } else {
                            return [];
                          }
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                              textDirection: TextDirection.rtl,
                              controller: controller,
                              focusNode: focusNode,
                              autofocus: false,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ابحث بجزء من اسم الصنف'));
                        },
                        itemBuilder: (context, item) {
                          final x = item;
                          return ListTile(
                            title: Text(
                              x.itemName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                        onSelected: (item) async {
                          addItemToGrid(item);
                        }),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showDealerSearch = !showDealerSearch;
                      });
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: openBarcode,
                    icon: Image.asset(
                      "assets/images/Barcode.png",
                      width: 50,
                      height: 50,
                    ),
                  )
                ],
              ),
              Visibility(
                visible: showDealerSearch,
                child: Column(
                  children: [
                    const SizedBox(height: 7),
                    SizedBox(
                      height: 50,
                      child: TypeAheadField<PosTblDealersModel>(
                        hideOnEmpty: true,
                        hideOnSelect: true,
                        hideWithKeyboard: true,
                        hideOnUnfocus: true,
                        controller: controlerDealerName,
                        suggestionsCallback: (pattern) async {
                          if (pattern.length > 1) {
                            return await SQLiteDbProvider.db
                                .getDealerByName(pattern);
                          } else {
                            return [];
                          }
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                              textDirection: TextDirection.rtl,
                              controller: controller,
                              focusNode: focusNode,
                              autofocus: false,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'اسم العميل'));
                        },
                        itemBuilder: (context, dealer) {
                          final x = dealer;
                          return ListTile(
                            title: Text(x.dealerName),
                          );
                        },
                        onSelected: (dealer) async {
                          setState(() {
                            controlerDealerName.text = dealer.dealerName;
                            FocusScope.of(context).unfocus();
                            GlobalVariables.hdr[0].dealerId = dealer.dealerID;
                            GlobalVariables.hdr[0].dealerIDSqlite =
                                dealer.dealerIDSqlite;
                            GlobalVariables.hdr[0].dealerName =
                                dealer.dealerName;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 7),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                color: Colors.blue[200],
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: Text("5", textAlign: TextAlign.center),
                    //   flex: 5,
                    // ),
                    Expanded(
                      flex: 21,
                      child: Text("الإجمالي", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 12,
                      child: Text("الكمية", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 17,
                      child: Text("السعر", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 45,
                      child: Text("المنتج", textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildDtl(context, index),
                    itemCount: GlobalVariables.dtl.length),
              ),
              // const Divider(
              //   color: Colors.grey,
              //   thickness: 1,
              // ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    top: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Text(
                                  textDirection: TextDirection.rtl,
                                  "صافي الفاتورة"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Text(
                                        textDirection: TextDirection.rtl,
                                        GlobalVariables.hdr.isNotEmpty
                                            ? GlobalVariables.hdr[0].docNetPrice
                                                .toStringAsFixed(2)
                                            : "0.00")),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(
                                  textDirection: TextDirection.rtl,
                                  "عدد القطع"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Text(
                                        textDirection: TextDirection.rtl,
                                        GlobalVariables.hdr.isNotEmpty
                                            ? GlobalVariables.hdr[0].qnt
                                                .toStringAsFixed(2)
                                            : "0.00")),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Divider(
              //   color: Colors.grey,
              //   thickness: 1,
              // ),
              Container(
                height: 30,
                width: double.infinity,
                color: Color.fromARGB(255, 226, 226, 226),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        GlobalVariables.hdr.isNotEmpty
                            ? GlobalVariables.hdr[0].tafqeet
                            : "",
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future openBarcode() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode != null) {
      List<PosTblBarcodeDtl> item_1 =
          await SQLiteDbProvider.db.getItemByBarcode(barcode);
      List<SCTblItemsModel> item =
          await SQLiteDbProvider.db.getItemByID(item_1[0].itemId);
      addItemToGrid(
          item[0], item_1[0].unitId, item_1[0].codeDtl, item_1[0].barcode);
    }
  }

  Future<void> addItemToGrid(SCTblItemsModel item,
      [int barcodeUnitID = 0, String codeDtl = '', String barcode = '']) async {
    List<FillSearchModel> fillSearch = await SQLiteDbProvider.db
        .getAllItemDataByID(item.itemID, agent.branchID, barcodeUnitID);
    // var x=GlobalVariables.dtl.firstWhere((element) => element.itemId==item.itemID);
    PosTblSalesDtlModel dtl1 = PosTblSalesDtlModel(
        recId: GlobalVariables.dtl.length + 1,
        serialId: 0,
        serialIdSqlite: GlobalVariables.hdr[0].serialIdSqlite,
        codeDtl: codeDtl == "" ? getCodeDtl(item.itemID.toString()) : codeDtl,
        branchIdDtl: agent.branchID,
        barCode: barcode,
        itemId: item.itemID,
        quantity: 1,
        stockQuantity: fillSearch[0].currentStock,
        unitId: item.devSalUnit,
        convParm: fillSearch[0].convParm,
        itemCost: item.lastCost,
        itemPrice: fillSearch[0].itemPrice1,
        itemCprice: fillSearch[0].itemPrice,
        totalCost: fillSearch[0].itemPrice,
        discPDtl: 0,
        discvDtl: 0,
        totDiscDtl: 0,
        totAddDtl: 0,
        netPrice: fillSearch[0].itemPrice1,
        invDistDisc: 0,
        invDistTotDisc: 0,
        invDistTotAdd: 0,
        priceID: fillSearch[0].priceOrder,
        salesDtlNote: "",
        discPDtl2: 0,
        discPDtl3: 0,
        totAddDtl2: 0,
        totAddDtl3: 0,
        totalPrice: fillSearch[0].itemPrice1,
        taxDtl1: item.tax1,
        taxDtl2: item.tax2,
        taxDtl3: item.tax3,
        taxDtlval1: fillSearch[0].itemPrice1 * item.tax1 / 100,
        taxDtlval2: fillSearch[0].itemPrice1 * item.tax2 / 100,
        taxDtlval3: fillSearch[0].itemPrice1 * item.tax3 / 100,
        itemName: item.itemName,
        unitName: item.unitName);
    FocusScope.of(context).unfocus();
    setState(() {
      controlerItemName.text = "";
      GlobalVariables.dtl.add(dtl1);
      calc();
    });
  }

  Widget buildDtl(BuildContext context, int index) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(
          //   flex: 5,
          //   child: ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           Dtl.removeAt(index);
          //         });
          //       },
          //       child: const Text(
          //         'X',
          //         style: TextStyle(fontSize: 20.0),
          //       )),
          // ),
          Expanded(
            flex: 21,
            child: getGesture(
                index,
                Text(GlobalVariables.dtl[index].netPrice.toStringAsFixed(2),
                    textAlign: TextAlign.center)),
          ),
          Expanded(
            flex: 12,
            child: getGesture(
                index,
                Text(GlobalVariables.dtl[index].quantity.toStringAsFixed(2),
                    textAlign: TextAlign.center)),
          ),
          Expanded(
            flex: 17,
            child: getGesture(
                index,
                Text(GlobalVariables.dtl[index].itemPrice.toStringAsFixed(2),
                    textAlign: TextAlign.center)),
          ),
          Expanded(
            flex: 45,
            child: getGesture(
                index,
                Text(GlobalVariables.dtl[index].itemName,
                    textAlign: TextAlign.center)),
          ),
        ],
      ),
    );
  }

  void goBack() {
    Navigator.pushReplacementNamed(context, HomeNewScreen.route);
  }

  String getCodeDtl(String itemCode) {
    return itemCode + "000000";
  }

  void openMenu() {}
  Widget getGesture(int index, Widget x) {
    return GestureDetector(
      onTap: () {
        controlerItemPrice.text =
            GlobalVariables.dtl[index].itemPrice.toString();
        controlerQuantity.text = GlobalVariables.dtl[index].quantity.toString();
        controlerTotalPrice.text =
            GlobalVariables.dtl[index].totalPrice.toString();
        controlerDiscVal.text = GlobalVariables.dtl[index].discvDtl.toString();
        controlerDiscPer.text = GlobalVariables.dtl[index].discPDtl.toString();
        controlerNote.text = GlobalVariables.dtl[index].salesDtlNote.toString();
        showDialog(
          context: context,
          builder: (BuildContext context) => itemDtlDialog(context, index),
        );
      },
      child: x,
    );
  }

  Widget getGestureHdr(Widget x) {
    return GestureDetector(
      onTap: () async {
        if (GlobalVariables.hdr.isEmpty) {
          PosTblSalesModel hdr1 = PosTblSalesModel(
              serialIdSqlite: await SQLiteDbProvider.db.getMaxCode());
          GlobalVariables.hdr.add(hdr1);
        }
        PosTblSalesModel hdr = GlobalVariables.hdr[0];
        controlerTotal.text = hdr.docTotal.toString();
        controlerDisc.text = hdr.discP.toString();
        controlerPaid.text = hdr.monyCash.toString();
        controlerRest.text = (hdr.docNetPrice - hdr.monyCash).toString();
        controlerDealerName.text = hdr.dealerName;
        showDialog(
          context: context,
          builder: (BuildContext context) =>  
            StatefulBuilder(
            builder: (context, StateSetter setState) =>AlertDialog(
            content :SingleChildScrollView(
              child: Column(
               textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Row(
                       children: <Widget>[
                      Expanded(
                        flex:1,
                        child: Radio(
                        activeColor: Colors.blue,
                        value: PayKind.visa,
                        groupValue: _payKind,
                        onChanged:(PayKind? value) {
                                  setState(() {
                                    _payKind = value;
                                  GlobalVariables.hdr[0].payKind =1 ; 
                                  print("PayKind Value :  ${GlobalVariables.hdr[0].payKind}");
                                           
                                           
                                  });}),
                      ),
                                       const Text(
                    ' بطاقة',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                       ),
                                         
                                       Expanded(
                                        flex:1,
                                         child: Radio(
                                                               activeColor: Colors.blue,
                                                               value: PayKind.agel,
                                                               groupValue: _payKind,
                                                               onChanged: (PayKind? value) {
                                                                         setState(() {
                                                                           _payKind = value;
                                                                         GlobalVariables.hdr[0].payKind =1 ; 
                                                                         print("PayKind Value :  ${GlobalVariables.hdr[0].payKind}");
                                                            
                                                            
                                                                         });}),
                                       ),
                                       const Text(
                    'أجل',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                       ),
                                       Expanded(
                                        flex:1,
                                         child: Radio(
                                                              activeColor: Colors.blue,
                                                             value: PayKind.cash,
                                                             groupValue: _payKind,
                                                             onChanged: (PayKind? value) {
                                                                         setState(() {
                                                                           _payKind = value;
                                                                         GlobalVariables.hdr[0].payKind =1 ; 
                                                                         print("PayKind Value :  ${GlobalVariables.hdr[0].payKind}");
                                                            
                                                            
                                                                         });},
                                         ),
                                       ),
                                       const Text(
                    'نقدي',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                       ),
                                     ],
                                   ),
                
                 SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(textDirection: TextDirection.rtl, "الإجمالي"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                            height: 35,
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: const BorderRadius.all(Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Text(
                                textDirection: TextDirection.rtl,
                                GlobalVariables.hdr[0].docTotal.toString())),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(textDirection: TextDirection.rtl, "الخصم"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Focus(
                          child: TextField(
                            controller: controlerDisc,
                            textDirection: TextDirection.rtl,
                            showCursor: false,
                            keyboardType: TextInputType.number,
                            onTap: () => controlerDisc.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controlerDisc.value.text.length),
                            onChanged: (text) {
                              setState(() {
                                GlobalVariables.hdr[0].discP = double.parse(text);
                              });
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.percent),
                                border: OutlineInputBorder()),
                          ),
                          onFocusChange: (hasFocus) {
                            if (hasFocus == false) {
                              FocusScope.of(context).unfocus();
                              calc();
                            }
                            ;
                          },
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10.0,
                      // ),
                      // const Text(textDirection: TextDirection.rtl, "%"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(textDirection: TextDirection.rtl, "المدفوع"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Focus(
                          child: TextField(
                            controller: controlerPaid,
                            textDirection: TextDirection.rtl,
                            showCursor: false,
                            keyboardType: TextInputType.number,
                            onTap: () => controlerPaid.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controlerPaid.value.text.length),
                            onChanged: (text) {
                              setState(() {
                                GlobalVariables.hdr[0].monyCash =
                                    double.parse(text);
                              });
                            },
                            decoration:
                                const InputDecoration(border: OutlineInputBorder()),
                          ),
                          onFocusChange: (hasFocus) {
                            if (hasFocus == false) {
                              FocusScope.of(context).unfocus();
                            }
                            ;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(textDirection: TextDirection.rtl, "الباقي"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                            height: 35,
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: const BorderRadius.all(Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Text(
                                textDirection: TextDirection.rtl,
                                (GlobalVariables.hdr[0].docNetPrice -
                                        GlobalVariables.hdr[0].monyCash)
                                    .toStringAsFixed(2))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(children: [
                  Expanded(
                    child: TypeAheadField<PosTblDealersModel>(
                      hideOnEmpty: true,
                      hideOnSelect: true,
                      hideWithKeyboard: true,
                      hideOnUnfocus: true,
                      controller: controlerDealerName,
                      suggestionsCallback: (pattern) async {
                        if (pattern.length > 1) {
                          return await SQLiteDbProvider.db.getDealerByName(pattern);
                        } else {
                          return [];
                        }
                      },
                      builder: (context, controller, focusNode) {
                        return TextField(
                            textDirection: TextDirection.rtl,
                            controller: controller,
                            focusNode: focusNode,
                            autofocus: false,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'اسم العميل'));
                      },
                      itemBuilder: (context, dealer) {
                        final x = dealer;
                        return ListTile(
                          title: Text(x.dealerName),
                        );
                      },
                      onSelected: (dealer) async {
                        setState(() {
                          controlerDealerName.text = dealer.dealerName;
                          FocusScope.of(context).unfocus();
                          GlobalVariables.hdr[0].dealerId = dealer.dealerID;
                          GlobalVariables.hdr[0].dealerIDSqlite =
                              dealer.dealerIDSqlite;
                          GlobalVariables.hdr[0].dealerName = dealer.dealerName;
                        });
                      },
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(textDirection: TextDirection.rtl, "ملاحظات"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controlerHdrNote,
                          textDirection: TextDirection.rtl,
                          decoration:
                              const InputDecoration(border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                         ]),
            ),
        
        
        actions: <Widget>[
          // ElevatedButton(
          //   onPressed: () {
          //     setState(() {
          //       // Dtl.remove(dtl);
          //       calc();
          //     });
          //     Navigator.of(context).pop();
          //   },
          //   child: const Text('الغاء'),
          // ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                GlobalVariables.hdr[0].discP = double.parse(controlerDisc.text);
                GlobalVariables.hdr[0].monyCash =
                    double.parse(controlerPaid.text);
                GlobalVariables.hdr[0].note = controlerHdrNote.text;
                calc();
              });
              Navigator.of(context).pop();
            },
            child: const Text('متابعة'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                GlobalVariables.hdr[0].docTotal =
                    double.parse(controlerTotal.text);
                GlobalVariables.hdr[0].discP = double.parse(controlerDisc.text);
                GlobalVariables.hdr[0].monyCash =
                    double.parse(controlerPaid.text);
                GlobalVariables.hdr[0].note = controlerHdrNote.text;
                calc();
              });
              final snackBar = SnackBar(
                content: const Text('تم الحفظ بنجاح'),
                action: SnackBarAction(
                  label: 'تنبيه',
                  onPressed: () {},
                ),
              );
              setState(() async {
                bool result = await InternetConnectionChecker().hasConnection;
                if (!result == true) {
                  final response = await Api.salesInsert(
                      GlobalVariables.hdr, GlobalVariables.dtl);
                  if (response == 200) {
                    //  GlobalVariables.hdr[0].serialIdSqlite
                    //   GlobalVariables.hdr[0].dealerId
                    //  'CREATE TABLE Pos_TblDealers (DealerID INTEGER,StoreId INTEGER,DealerCode TEXT,DealerName TEXT,GlRefID INTEGER,GlRefCode TEXT,DealerCat TEXT,SalPriceID INTEGER,PriceListID INTEGER,AllowCredit INTEGER,CreditLimit NUMERIC,AgentID INTEGER,RegionID INTEGER,Mobile Text,Address Text,Segel Text,TaxCard Text,DealerIDSqlite INTEGER)',
                    setState(() {
                      GlobalVariables.hdr[0].docTotal =
                          double.parse(controlerTotal.text);
                      GlobalVariables.hdr[0].discP =
                          double.parse(controlerDisc.text);
                      GlobalVariables.hdr[0].monyCash =
                          double.parse(controlerPaid.text);
                      GlobalVariables.hdr[0].note = controlerHdrNote.text;
                      calc();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  //   int? result = await SQLiteDbProvider.db.saveSalesInv(GlobalVariables.hdr[0], GlobalVariables.dtl);
                  //     if (result != null && result != 0) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveInvoiceDialog(
                        context: context,
                        printEvent: () async {
              
                 //  final pdf =  await generatePdfAndPrinting(
                        //    DataOfDtl: GlobalVariables.dtl,
                     //       DataOfHdr: GlobalVariables.hdr,
                   //       );
                          AppNavigator.navigateTo(context, Texting());
                        },
                        whatsEvent: () async {
                          File file = await generatePdfAndsendtowhatsapp(
                            DataOfDtl: GlobalVariables.dtl,
                            DataOfHdr: GlobalVariables.hdr,
                          );
                          print(" File Name : ${file.path}");
                          await WhatsappShare.isInstalled(
                                  package: Package.whatsapp)
                              .then((val) async {
                            await WhatsappShare.shareFile(
                              phone: '201009528669',
                              filePath: ["${file.path}"],
                            ).catchError((error) {
                              print(error.toString());
                            });
                          });
                        },
                        InvoiceNum:
                            GlobalVariables.hdr[0].serialIdSqlite.toString()),
                  );
      
                  setState(() {
                    calc();
                  });
                  //   }
                }
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      )
        
           )
        );
      },
      child: x,
    );
  }

  var controlerItemName = TextEditingController();
  var controlerDealerName = TextEditingController();

  var controlerItemPrice = TextEditingController();
  var controlerQuantity = TextEditingController();
  var controlerTotalPrice = TextEditingController();
  var controlerDiscVal = TextEditingController();
  var controlerDiscPer = TextEditingController();
  var controlerNote = TextEditingController();
  var controlerTotal = TextEditingController();
  var controlerDisc = TextEditingController();
  var controlerPaid = TextEditingController();
  var controlerRest = TextEditingController();
  var controlerHdrNote = TextEditingController();
  Widget itemDtlDialog(BuildContext context, int index) {
    return AlertDialog(
      title: Text(
          textDirection: TextDirection.rtl,
          GlobalVariables.dtl[index].itemName),
      content: Column(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "الوحدة"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                      ),
                      child: Text(
                          textDirection: TextDirection.rtl,
                          GlobalVariables.dtl[index].unitName)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "سعر البيع"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Focus(
                    child: TextField(
                      controller: controlerItemPrice,
                      textDirection: TextDirection.rtl,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      onTap: () => controlerItemPrice.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controlerItemPrice.value.text.length),
                      onChanged: (text) {
                        setState(() {
                          GlobalVariables.dtl[0].itemPrice = double.parse(text);
                        });
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    onFocusChange: (hasFocus) {
                      if (hasFocus == false) {
                        FocusScope.of(context).unfocus();
                      }
                      ;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "الكمية"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Focus(
                    child: TextField(
                      controller: controlerQuantity,
                      textDirection: TextDirection.rtl,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      onTap: () => controlerQuantity.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controlerQuantity.value.text.length),
                      onChanged: (text) {
                        setState(() {
                          GlobalVariables.dtl[0].quantity = double.parse(text);
                        });
                      },
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(0),
                      ),
                    ),
                    onFocusChange: (hasFocus) {
                      if (hasFocus == false) {
                        FocusScope.of(context).unfocus();
                      }
                      ;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(textDirection: TextDirection.rtl, "اجمالي السعر"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                      ),
                      child: Text(
                          textDirection: TextDirection.rtl,
                          (double.parse(controlerQuantity.text) *
                                  double.parse(controlerItemPrice.text))
                              .toString())),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "خصم قيمة"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Focus(
                    child: TextField(
                      controller: controlerDiscVal,
                      textDirection: TextDirection.rtl,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      onTap: () => controlerDiscVal.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controlerDiscVal.value.text.length),
                      onChanged: (text) {
                        setState(() {
                          GlobalVariables.dtl[0].discvDtl = double.parse(text);
                        });
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    onFocusChange: (hasFocus) {
                      if (hasFocus == false) {
                        FocusScope.of(context).unfocus();
                      }
                      ;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(textDirection: TextDirection.rtl, "خصم نسبة"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Focus(
                    child: TextField(
                      controller: controlerDiscPer,
                      textDirection: TextDirection.rtl,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      onTap: () => controlerDiscPer.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controlerDiscPer.value.text.length),
                      onChanged: (text) {
                        setState(() {
                          GlobalVariables.dtl[0].discPDtl = double.parse(text);
                        });
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    onFocusChange: (hasFocus) {
                      if (hasFocus == false) {
                        FocusScope.of(context).unfocus();
                      }
                      ;
                    },
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                const Text(textDirection: TextDirection.rtl, "%"),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "ملاحظات"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    controller: controlerNote,
                    textDirection: TextDirection.rtl,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 35,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text(textDirection: TextDirection.rtl, "رصيد الصنف"),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                      ),
                      child: Text(
                          textDirection: TextDirection.rtl,
                          GlobalVariables.dtl[index].stockQuantity.toString())),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              GlobalVariables.dtl.removeAt(index);
              calc();
            });
            Navigator.of(context).pop();
          },
          child: const Text('حذف من الفاتورة'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              GlobalVariables.dtl[index].itemPrice =
                  double.parse(controlerItemPrice.text);
              GlobalVariables.dtl[index].quantity =
                  double.parse(controlerQuantity.text);
              GlobalVariables.dtl[index].totalPrice =
                  double.parse(controlerTotalPrice.text);
              GlobalVariables.dtl[index].discvDtl =
                  double.parse(controlerDiscVal.text);
              GlobalVariables.dtl[index].discPDtl =
                  double.parse(controlerDiscPer.text);
              GlobalVariables.dtl[index].salesDtlNote = controlerNote.text;
              calc();
            });
            Navigator.of(context).pop();
          },
          child: const Text('متابعة'),
        ),
      ],
    );
  }

//  void handleSelection2(PayKind? value) {
//     setState(() {
//      _payKind = value;
//       GlobalVariables.hdr[0].payKind ;     
//  if (_payKind==PayKind.cash)
// {
// setState(() {
//    GlobalVariables.hdr[0].payKind=1;
//    print(GlobalVariables.hdr[0].payKind);
// });

//  } else if (_payKind==PayKind.agel)
//   {
// setState(() {
//     GlobalVariables.hdr[0].payKind=2;
//   print(GlobalVariables.hdr[0].payKind);
// });
//    }
//  else if (_payKind==PayKind.visa)
//   {
//   setState(() {
//         GlobalVariables.hdr[0].payKind=5;
//   print(GlobalVariables.hdr[0].payKind);
    
//   });

//   }
//   });
//  }


 

  double netTot = 0;
  Future<void> calc() async {
    GlobalVariables.hdr[0].qnt = 0;
    netTot = 0;
    for (var i = 0; i < GlobalVariables.dtl.length; i++) {
      GlobalVariables.dtl[i].recId = i + 1;
      GlobalVariables.hdr[0].qnt += GlobalVariables.dtl[i].quantity;
      GlobalVariables.dtl[i].totalCost = GlobalVariables.dtl[i].itemCost *
          GlobalVariables.dtl[i].quantity *
          GlobalVariables.dtl[i].convParm;
      GlobalVariables.dtl[i].totalPrice =
          GlobalVariables.dtl[i].itemPrice * GlobalVariables.dtl[i].quantity;
      GlobalVariables.dtl[i].taxDtlval1 = ((GlobalVariables.dtl[i].totalPrice -
              (GlobalVariables.dtl[i].totalPrice *
                  GlobalVariables.dtl[i].discPDtl /
                  100) +
              GlobalVariables.dtl[i].totAddDtl -
              ((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl) *
                  GlobalVariables.dtl[i].discPDtl2 /
                  100) +
              GlobalVariables.dtl[i].totAddDtl2 -
              ((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl -
                      ((GlobalVariables.dtl[i].totalPrice -
                              (GlobalVariables.dtl[i].totalPrice *
                                  GlobalVariables.dtl[i].discPDtl /
                                  100) +
                              GlobalVariables.dtl[i].totAddDtl) *
                          GlobalVariables.dtl[i].discPDtl2 /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl2) *
                  GlobalVariables.dtl[i].discPDtl3 /
                  100) -
              GlobalVariables.dtl[i].discvDtl -
              GlobalVariables.dtl[i].totDiscDtl +
              GlobalVariables.dtl[i].totAddDtl3) *
          (GlobalVariables.dtl[i].taxDtl1 / 100));

      GlobalVariables.dtl[i].taxDtlval2 = ((GlobalVariables.dtl[i].totalPrice -
              (GlobalVariables.dtl[i].totalPrice *
                  GlobalVariables.dtl[i].discPDtl /
                  100) +
              GlobalVariables.dtl[i].totAddDtl -
              ((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl) *
                  GlobalVariables.dtl[i].discPDtl2 /
                  100) +
              GlobalVariables.dtl[i].totAddDtl2 -
              ((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl -
                      ((GlobalVariables.dtl[i].totalPrice -
                              (GlobalVariables.dtl[i].totalPrice *
                                  GlobalVariables.dtl[i].discPDtl /
                                  100) +
                              GlobalVariables.dtl[i].totAddDtl) *
                          GlobalVariables.dtl[i].discPDtl2 /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl2) *
                  GlobalVariables.dtl[i].discPDtl3 /
                  100) -
              GlobalVariables.dtl[i].discvDtl -
              GlobalVariables.dtl[i].totDiscDtl +
              GlobalVariables.dtl[i].totAddDtl3) *
          (GlobalVariables.dtl[i].taxDtl2 / 100));

      GlobalVariables.dtl[i].taxDtlval3 = ((((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl -
                      ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) *
                          GlobalVariables.dtl[i].discPDtl2 /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl2 -
                      ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) * GlobalVariables.dtl[i].discPDtl2 / 100) + GlobalVariables.dtl[i].totAddDtl2) *
                          GlobalVariables.dtl[i].discPDtl3 /
                          100) -
                      GlobalVariables.dtl[i].discvDtl -
                      GlobalVariables.dtl[i].totDiscDtl +
                      GlobalVariables.dtl[i].totAddDtl3) +
                  ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) + GlobalVariables.dtl[i].discPDtl2 / 100) + GlobalVariables.dtl[i].totAddDtl2 - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) * GlobalVariables.dtl[i].discPDtl2 / 100) + GlobalVariables.dtl[i].totAddDtl2) * GlobalVariables.dtl[i].discPDtl3 / 100) - GlobalVariables.dtl[i].discvDtl - GlobalVariables.dtl[i].totDiscDtl + GlobalVariables.dtl[i].totAddDtl3) *
                      (GlobalVariables.dtl[i].taxDtl1 / 100))) +
              (((GlobalVariables.dtl[i].totalPrice -
                      (GlobalVariables.dtl[i].totalPrice *
                          GlobalVariables.dtl[i].discPDtl /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl -
                      ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) *
                          GlobalVariables.dtl[i].discPDtl2 /
                          100) +
                      GlobalVariables.dtl[i].totAddDtl2 -
                      ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) * GlobalVariables.dtl[i].discPDtl2 / 100) + GlobalVariables.dtl[i].totAddDtl2) *
                          GlobalVariables.dtl[i].discPDtl3 /
                          100) -
                      GlobalVariables.dtl[i].discvDtl -
                      GlobalVariables.dtl[i].totDiscDtl +
                      GlobalVariables.dtl[i].totAddDtl3) +
                  ((GlobalVariables.dtl[i].totalPrice -
                          (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) +
                          GlobalVariables.dtl[i].totAddDtl -
                          ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) * GlobalVariables.dtl[i].discPDtl2 / 100) +
                          GlobalVariables.dtl[i].totAddDtl2 -
                          ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl - ((GlobalVariables.dtl[i].totalPrice - (GlobalVariables.dtl[i].totalPrice * GlobalVariables.dtl[i].discPDtl / 100) + GlobalVariables.dtl[i].totAddDtl) * GlobalVariables.dtl[i].discPDtl2 / 100) + GlobalVariables.dtl[i].totAddDtl2) * GlobalVariables.dtl[i].discPDtl3 / 100) -
                          GlobalVariables.dtl[i].discvDtl -
                          GlobalVariables.dtl[i].totDiscDtl +
                          GlobalVariables.dtl[i].totAddDtl3) *
                      (GlobalVariables.dtl[i].taxDtl1 / 100))))) *
          (GlobalVariables.dtl[i].taxDtl3 / 100));

      GlobalVariables.dtl[i].netPrice = GlobalVariables.dtl[i].totalPrice -
          (GlobalVariables.dtl[i].totalPrice *
              GlobalVariables.dtl[i].discPDtl /
              100) +
          GlobalVariables.dtl[i].totAddDtl -
          ((GlobalVariables.dtl[i].totalPrice -
                  (GlobalVariables.dtl[i].totalPrice *
                      GlobalVariables.dtl[i].discPDtl /
                      100) +
                  GlobalVariables.dtl[i].totAddDtl) *
              GlobalVariables.dtl[i].discPDtl2 /
              100) +
          GlobalVariables.dtl[i].totAddDtl2 -
          ((GlobalVariables.dtl[i].totalPrice -
                  (GlobalVariables.dtl[i].totalPrice *
                      GlobalVariables.dtl[i].discPDtl /
                      100) +
                  GlobalVariables.dtl[i].totAddDtl -
                  ((GlobalVariables.dtl[i].totalPrice -
                          (GlobalVariables.dtl[i].totalPrice *
                              GlobalVariables.dtl[i].discPDtl /
                              100) +
                          GlobalVariables.dtl[i].totAddDtl) *
                      GlobalVariables.dtl[i].discPDtl2 /
                      100) +
                  GlobalVariables.dtl[i].totAddDtl2) *
              GlobalVariables.dtl[i].discPDtl3 /
              100) -
          GlobalVariables.dtl[i].discvDtl -
          GlobalVariables.dtl[i].totDiscDtl +
          GlobalVariables.dtl[i].totAddDtl3 +
          GlobalVariables.dtl[i].taxDtlval1 -
          GlobalVariables.dtl[i].taxDtlval2 +
          GlobalVariables.dtl[i].taxDtlval3;
      netTot += GlobalVariables.dtl[i].netPrice;
    }
    if (GlobalVariables.hdr.isEmpty) {
      GlobalVariables.hdr.add(PosTblSalesModel(
          serialIdSqlite: await SQLiteDbProvider.db.getMaxCode()));
    }
    GlobalVariables.hdr[0].docTotal = netTot;
    GlobalVariables.hdr[0].docNetPrice =
        netTot - (netTot * GlobalVariables.hdr[0].discP / 100);
    int x = GlobalVariables.hdr[0].docNetPrice.toInt();
    int? y = int.tryParse(GlobalVariables.hdr[0].docNetPrice
            .toStringAsFixed(2)
            .split('.')[1]) ??
        0;
    GlobalVariables.hdr[0].tafqeet = tafqit.tafqitNumberWithParts(
        listOfNumberAndParts: [x, y],
        tafqitUnitCode: TafqitUnitCode.egyptianPound)!;
  }
}
