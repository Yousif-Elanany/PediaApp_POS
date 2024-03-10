import 'package:flutter/cupertino.dart';
import 'package:pediaPOS/Data/API_Methods/Sales_data.dart';
import 'package:pediaPOS/Data/Models/SalesBillDtl_model.dart';
import 'package:pediaPOS/Data/Models/SalesBills_model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';

class PurchaseProvider extends ChangeNotifier {
  late ProviderGeneralState<List<SalesModel>> purchaseState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SalesDtlModel>> purchaseState2 =
      ProviderGeneralState(waiting: true);
  SalesData purchaseData = SalesData();
  bool isLoading = false;

  listen() {
    notifyListeners();
  }

  getPurchaseBills(String companyID, String dateFrom, String dateTo) async {
    List<SalesModel> getPurchase = [];
    setWaiting(purchaseState);
    getPurchase =
        await purchaseData.getPurchaseBills(companyID, dateFrom, dateTo);
    purchaseState = ProviderGeneralState(data: getPurchase, hasData: true);
    notifyListeners();
  }

  getPurchaseBillDtl(String serialID) async {
    List<SalesDtlModel> getPurchase = [];
    setWaiting(purchaseState);
    getPurchase = await purchaseData.getPurchaseBillDtl(serialID);
    purchaseState2 = ProviderGeneralState(data: getPurchase, hasData: true);
    notifyListeners();
  }

  void setWaiting(ProviderGeneralState providerGeneralState) {
    providerGeneralState = ProviderGeneralState(waiting: true);
  }
}
