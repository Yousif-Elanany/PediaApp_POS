import 'package:pediaPOS/Data/Models/DealersAccSheet_model.dart';
import 'package:pediaPOS/Data/Models/DealersBalance_model.dart';
import 'package:pediaPOS/Data/Models/DealersData_model.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/network/serviceshandler.dart';

class DealersData {
  getDealersBalance(
      String companyID, String dateFrom, String dateTo, int dealerType) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<DealersBalanceModel> balanceList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=AccDealersBalanceSheet&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"DStartDate\" : \"$dateFrom\",    \"DEndDate\" : \"$dateTo\",    \"NDealerType\" : \"$dealerType\"  }]&Constr=$conn");
    response.forEach((v) {
      DealersBalanceModel dealersBalanceModel = DealersBalanceModel.fromJson(v);
      balanceList.add(dealersBalanceModel);
    });
    return balanceList;
  }

  getDealersACCSheet(String companyID, String dateFrom, String dateTo,
      int dealerType, String dealerCode) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<DealersACCSheetModel> accList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=AccSheetDealers&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"DStartDate\" : \"$dateFrom\",    \"DEndDate\" : \"$dateTo\",    \"NDealerType\" : \"$dealerType\",    \"TDealerStart\" : \"$dealerCode\",    \"TDealerEnd\" : \"$dealerCode\"  }]&Constr=$conn");
    response.forEach((v) {
      DealersACCSheetModel dealersACCSheetModel =
          DealersACCSheetModel.fromJson(v);
      accList.add(dealersACCSheetModel);
    });
    return accList;
  }

  getDealersData(String companyID, int dealerType, String dealerName) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    List<DealersDataModel> dealersList = [];
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=Dealers_Search_&Params=[  {    \"NcopmanyID\" : \"$companyID\",   \"NDealerType\" : \"$dealerType\",   \"NDealerName\" : \"$dealerName\" }]&Constr=$conn");
    response.forEach((v) {
      DealersDataModel dealersDataModel = DealersDataModel.fromJson(v);
      dealersList.add(dealersDataModel);
    });
    return dealersList;
  }
}
