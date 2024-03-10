import 'package:pediaPOS/Data/Models/Home_model.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/network/serviceshandler.dart';

class HomeData {
  getHomeData(String dateFrom, String dateTo) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var userID = CacheHelper.getData(key: "User_ID");
    HomeModel homeModel;
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_homeData&Params=[  {    \"NuserID\" : \"$userID\",    \"DfromDate\" : \"$dateFrom\",    \"DtoDate\" : \"$dateTo\"  }]&Constr=$conn");
    homeModel = HomeModel.fromJson(response[0]);
    return homeModel;
  }
}
