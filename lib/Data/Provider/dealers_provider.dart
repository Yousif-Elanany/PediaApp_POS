import 'package:flutter/cupertino.dart';
import 'package:pediaPOS/Data/API_Methods/dealers_data.dart';
import 'package:pediaPOS/Data/Models/DealersAccSheet_model.dart';
import 'package:pediaPOS/Data/Models/DealersBalance_model.dart';
import 'package:pediaPOS/Data/Models/DealersData_model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';

class DealersProvider extends ChangeNotifier {
  late ProviderGeneralState<List<DealersBalanceModel>> dealersBalanceState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<DealersACCSheetModel>> dealerAccState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<DealersDataModel>> dealersDataState =
      ProviderGeneralState(waiting: true);
  DealersData dealersData = DealersData();

  listen() {
    notifyListeners();
  }

  getDealersBalance(
      String companyID, String dateFrom, String dateTo, int dealerType) async {
    List<DealersBalanceModel> getBalance = [];
    setWaiting(dealersBalanceState);
    getBalance = await dealersData.getDealersBalance(
        companyID, dateFrom, dateTo, dealerType);
    dealersBalanceState = ProviderGeneralState(data: getBalance, hasData: true);
    notifyListeners();
  }

  getDealersACCSheet(String companyID, String dateFrom, String dateTo,
      int dealerType, String dealerCode) async {
    List<DealersACCSheetModel> getAcc = [];
    setWaiting(dealerAccState);
    getAcc = await dealersData.getDealersACCSheet(
        companyID, dateFrom, dateTo, dealerType, dealerCode);
    dealerAccState = ProviderGeneralState(data: getAcc, hasData: true);
    notifyListeners();
  }

  getDealersData(String companyID, int dealerType, String dealerName) async {
    List<DealersDataModel> getData = [];
    setWaiting(dealersDataState);
    getData =
        await dealersData.getDealersData(companyID, dealerType, dealerName);
    dealersDataState = ProviderGeneralState(data: getData, hasData: true);
    notifyListeners();
  }

  void setWaiting(ProviderGeneralState providerGeneralState) {
    providerGeneralState = ProviderGeneralState(waiting: true);
  }
}
