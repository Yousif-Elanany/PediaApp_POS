import 'package:flutter/cupertino.dart';
import 'package:pediaPOS/Data/API_Methods/Sales_data.dart';
import 'package:pediaPOS/Data/Models/SalesBillDtl_model.dart';
import 'package:pediaPOS/Data/Models/SalesBills_model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';

class SalesProvider extends ChangeNotifier {
  late ProviderGeneralState<List<SalesModel>> salesState =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SalesDtlModel>> salesState2 =
      ProviderGeneralState(waiting: true);
  SalesData salesData = SalesData();
  bool isLoading = false;

  listen() {
    notifyListeners();
  }

  getSalesBills(String companyID, String dateFrom, String dateTo) async {
    List<SalesModel> getSales = [];
    setWaiting(salesState);
    getSales = await salesData.getSalesBills(companyID, dateFrom, dateTo);
    salesState = ProviderGeneralState(data: getSales, hasData: true);
    notifyListeners();
  }

  getSalesBillDtl(String serialID) async {
    List<SalesDtlModel> getSales = [];
    setWaiting(salesState);
    getSales = await salesData.getSalesBillDtl(serialID);
    salesState2 = ProviderGeneralState(data: getSales, hasData: true);
    notifyListeners();
  }

  void setWaiting(ProviderGeneralState providerGeneralState) {
    providerGeneralState = ProviderGeneralState(waiting: true);
  }
}
