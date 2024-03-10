import 'dart:convert';

import 'package:pediaPOS/Data/Models/SalesBillDtl_model.dart';
import 'package:pediaPOS/Data/Models/SalesBills_model.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/network/serviceshandler.dart';

import '../../network/sqlite.dart';
import '../Models/SQLiteModels/pos_tbldealers_model.dart';
import '../Models/SQLiteModels/pos_tblsales_dtl_model.dart';
import '../Models/SQLiteModels/pos_tblsales_model.dart';

class SalesData {
  static final SQLiteDbProvider db = SQLiteDbProvider();
  getSalesBills(String companyID, String dateFrom, String dateTo) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<SalesModel> salesList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=Api_SalesTotals&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"DfromDate\" : \"$dateFrom\",    \"DtoDate\" : \"$dateTo\"  }]&Constr=$conn");
    response.forEach((v) {
      SalesModel lastOrderModel = SalesModel.fromJson(v);
      salesList.add(lastOrderModel);
    });
    return salesList;
  }

  getSalesBillDtl(String serialID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<SalesDtlModel> salesList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=Api_SalesBillDtl&Params=[  {    \"NserialID\" : \"$serialID\" }]&Constr=$conn");
    response.forEach((v) {
      SalesDtlModel lastOrderModel = SalesDtlModel.fromJson(v);
      salesList.add(lastOrderModel);
    });
    return salesList;
  }

  getPurchaseBills(String companyID, String dateFrom, String dateTo) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<SalesModel> salesList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=Api_PurchaseTotals&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"DfromDate\" : \"$dateFrom\",    \"DtoDate\" : \"$dateTo\"  }]&Constr=$conn");
    response.forEach((v) {
      SalesModel lastOrderModel = SalesModel.fromJson(v);
      salesList.add(lastOrderModel);
    });
    return salesList;
  }

  getPurchaseBillDtl(String serialID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<SalesDtlModel> salesList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=Api_PurchaseBillDtl&Params=[  {    \"NserialID\" : \"$serialID\" }]&Constr=$conn");
    response.forEach((v) {
      SalesDtlModel lastOrderModel = SalesDtlModel.fromJson(v);
      salesList.add(lastOrderModel);
    });
    return salesList;
  }

  salesInsert(List<PosTblSalesModel> hdr,List<PosTblSalesDtlModel> dtl) async {
    try {
      var conn = CacheHelper.getData(key: "Conn_str");
      List<PosTblDealersModel> dealers=await SQLiteDbProvider.db.getAllDealers();
      var jsonhdr =(hdr.map((e) => e.toMap()).toList());
      var jsondtl =(dtl.map((e) => e.toMap()).toList());
      var jsondealers =(dealers.map((e) => e.toMap()).toList());
      var response = await ServicesHandler().getServiceJSON(proName:"Api_Sales_Insert",params: {    'hdr' : jsonhdr,    'dtl' : jsondtl,    'dealers' : jsondealers  },constr:conn);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
