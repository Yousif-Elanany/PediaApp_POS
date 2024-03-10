import 'package:flutter/cupertino.dart';
import 'package:pediaPOS/Data/API_Methods/home_data.dart';
import 'package:pediaPOS/Data/Models/Home_model.dart';
import 'package:pediaPOS/Data/Provider/providergeneralstate.dart';

class HomeProvider extends ChangeNotifier {
  late ProviderGeneralState<HomeModel> homeState =
      ProviderGeneralState(waiting: true);
  HomeData homeData = HomeData();
  bool isLoading = false;

  listen() {
    notifyListeners();
  }

  getHomeData(String dateFrom, String dateTo) async {
    HomeModel homeModel;
    homeModel = await homeData.getHomeData(dateFrom, dateTo);
    homeState = ProviderGeneralState(data: homeModel, hasData: true);
    notifyListeners();
  }

  void setWaiting(ProviderGeneralState providerGeneralState) {
    providerGeneralState = ProviderGeneralState(waiting: true);
  }
}
