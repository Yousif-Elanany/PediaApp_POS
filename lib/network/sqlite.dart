import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pediaPOS/network/serviceshandler.dart';
import 'package:pediaPOS/network/sqlite_script.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/Models/SQLiteModels/fill_search_model.dart';
import '../Data/Models/SQLiteModels/mg_tbldocs_model.dart';
import '../Data/Models/SQLiteModels/pos_prices_model.dart';
import '../Data/Models/SQLiteModels/pos_tblbarcodedtl.dart';
import '../Data/Models/SQLiteModels/pos_tbldealers_model.dart';
import '../Data/Models/SQLiteModels/pos_tblsales_dtl_model.dart';
import '../Data/Models/SQLiteModels/pos_tblsales_model.dart';
import '../Data/Models/SQLiteModels/sc_tblitem_units_model.dart';
import '../Data/Models/SQLiteModels/sc_tblitemprices_model.dart';
import '../Data/Models/SQLiteModels/sc_tblitems_model.dart';
import '../Data/Models/SQLiteModels/sc_tblitemstocks_model.dart';
import '../Data/Models/SQLiteModels/sc_tblunits_model.dart';
import '../Data/Models/agent_model.dart';
import '../Data/Provider/providergeneralstate.dart';
import 'cache_helper.dart';

class SQLiteDbProvider extends ChangeNotifier {
  static final SQLiteDbProvider db = SQLiteDbProvider();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "TStocks.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      for (var script in SqliteScript().createScripts) {
        await db.execute(script);
      }
    });
  }

  void setWaiting(ProviderGeneralState providerGeneralState) {
    providerGeneralState = ProviderGeneralState(waiting: true);
  }

  late ProviderGeneralState<List<SCTblItemsModel>> items =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SCTblItemStocksModel>> itemsStocks =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SCTblItemPricesModel>> itemsPrices =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SCTblItemUnitsModel>> itemsUnits =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<PosTblDealersModel>> dealers =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<PosPricesModel>> prices =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<MGTblDocsModel>> docs =
      ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<AgentModel>> agents =
  ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<SCTblUnitsModel>> units =
  ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List<PosTblBarcodeDtl>> barcodes =
  ProviderGeneralState(waiting: true);


  fillDataFromLocal(String companyID, String branchID, String userID) async {
    await fillMGTblDocs(companyID, branchID, userID);
    await fillPosTblDealers(companyID, branchID, userID);
    await fillSCTblItems(companyID, branchID, userID);
    await fillSCTblItemStocks(companyID, branchID, userID);
    await fillSCTblItemPrices(companyID, branchID, userID);
    await fillSCTblItemUnits(companyID, branchID, userID);
    await fillPosPrices(companyID, branchID, userID);
    await fillAgent();
    await fillUnits(companyID);
    await fillBarcodes(companyID);
  }

  fillMGTblDocs(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_MGTblDocs_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM MG_TblDocs");
    List<MGTblDocsModel> listDocs = [];
    response.forEach((doc) async {
      if (doc != null) {
        await db.insert(
          'MG_TblDocs',
          doc,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        MGTblDocsModel tblDocsModel = MGTblDocsModel.fromJson(doc);
        listDocs.add(tblDocsModel);
      }
    });
    setWaiting(docs);
    docs = ProviderGeneralState(data: listDocs, hasData: true);
    notifyListeners();
  }

  fillPosTblDealers(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_PosTblDealers_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM Pos_TblDealers");
    List<PosTblDealersModel> listDealers = [];
    response.forEach((dealer) async {
      if (dealer != null) {
        await db.insert(
          'Pos_TblDealers',
          dealer,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        PosTblDealersModel tblDealersModel =
            PosTblDealersModel.fromJson(dealer);
        listDealers.add(tblDealersModel);
      }
    });
    setWaiting(dealers);
    dealers = ProviderGeneralState(data: listDealers, hasData: true);
    notifyListeners();
  }

  fillSCTblItems(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_SCTblItems_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM SC_TblItems");
    List<SCTblItemsModel> listItem = [];
    response.forEach((item) async {
      if (item != null) {
        await db.insert(
          'SC_TblItems',
          item,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        SCTblItemsModel tblItemsModel = SCTblItemsModel.fromJson(item);
        listItem.add(tblItemsModel);
      }
    });
    setWaiting(items);
    items = ProviderGeneralState(data: listItem, hasData: true);
    notifyListeners();
  }
  fillAgent() async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var userID = CacheHelper.getData(key: "User_ID");
    var response = await ServicesHandler().getService(
        urlSuffix:
        "select?proName=API_getAgentData&Params=[%20{%20%22NUserID%22:%20$userID%20}%20]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM Pos_TblAgent");
    List<AgentModel> listAgents = [];
    response.forEach((agent) async {
      if (agent != null) {
        await db.insert(
          'Pos_TblAgent',
          agent,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        AgentModel agentModel = AgentModel.fromJson(agent);
        listAgents.add(agentModel);
      }
    });
    setWaiting(agents);
    agents = ProviderGeneralState(data: listAgents, hasData: true);
    notifyListeners();
  }
  fillUnits(String companyID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
        "select?proName=API_getUnits&Params=[%20{%20%22NCompanyID%22:%20$companyID%20}%20]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM SC_TblUnits");
    List<SCTblUnitsModel> listUnits = [];
    response.forEach((unit) async {
      if (unit != null) {
        await db.insert(
          'SC_TblUnits',
          unit,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        SCTblUnitsModel unitsModel = SCTblUnitsModel.fromJson(unit);
        listUnits.add(unitsModel);
      }
    });
    setWaiting(units);
    units = ProviderGeneralState(data: listUnits, hasData: true);
    notifyListeners();
  }
  fillBarcodes(String companyID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
        "select?proName=API_getBarcodes&Params=[%20{%20%22NCompanyID%22:%20$companyID%20}%20]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM Pos_TblBarcodeDtl");
    List<PosTblBarcodeDtl> listBarcodes = [];
    response.forEach((barcode) async {
      if (barcode != null) {
        await db.insert(
          'Pos_TblBarcodeDtl',
          barcode,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        PosTblBarcodeDtl barcodesModel = PosTblBarcodeDtl.fromJson(barcode);
        listBarcodes.add(barcodesModel);
      }
    });
    setWaiting(barcodes);
    barcodes = ProviderGeneralState(data: listBarcodes, hasData: true);
    notifyListeners();
  }
  fillSCTblItemStocks(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_SCTblItemStocks_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM SC_TblItemStocks");
    List<SCTblItemStocksModel> listItemStocks = [];
    response.forEach((itemStock) async {
      if (itemStock != null) {
        await db.insert(
          'SC_TblItemStocks',
          itemStock,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        SCTblItemStocksModel tblItemStocksModel =
            SCTblItemStocksModel.fromJson(itemStock);
        listItemStocks.add(tblItemStocksModel);
      }
    });
    setWaiting(itemsStocks);
    itemsStocks = ProviderGeneralState(data: listItemStocks, hasData: true);
    notifyListeners();
  }

  fillSCTblItemPrices(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_SCTblItemPrices_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM SC_TblItemPrices");
    List<SCTblItemPricesModel> listItemsPrices = [];
    response.forEach((itemPrice) async {
      if (itemPrice != null) {
        await db.insert(
          'SC_TblItemPrices',
          itemPrice,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        SCTblItemPricesModel tblItemPricesModel =
            SCTblItemPricesModel.fromJson(itemPrice);
        listItemsPrices.add(tblItemPricesModel);
      }
    });
    setWaiting(itemsPrices);
    itemsPrices = ProviderGeneralState(data: listItemsPrices, hasData: true);
    notifyListeners();
  }

  fillSCTblItemUnits(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_SCTblItemUnits_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM SC_TblItem_Units");
    List<SCTblItemUnitsModel> listItemsUnits = [];
    response.forEach((itemUnit) async {
      if (itemUnit != null) {
        await db.insert(
          'SC_TblItem_Units',
          itemUnit,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        SCTblItemUnitsModel tblItemUnitsModel =
            SCTblItemUnitsModel.fromJson(itemUnit);
        listItemsUnits.add(tblItemUnitsModel);
      }
    });
    setWaiting(itemsUnits);
    itemsUnits = ProviderGeneralState(data: listItemsUnits, hasData: true);
    notifyListeners();
  }

  fillPosPrices(String companyID, String branchID, String userID) async {
    var conn = CacheHelper.getData(key: "Conn_str");
    var response = await ServicesHandler().getService(
        urlSuffix:
            "select?proName=API_PosPrices_select&Params=[  {    \"NcompanyID\" : \"$companyID\",    \"NbranchID\" : \"$branchID\",    \"NuserID\" : \"$userID\"} ]&Constr=$conn");
    final db = await database;
    await db!.rawDelete("DELETE FROM Pos_Prices");
    List<PosPricesModel> listPrices = [];
    response.forEach((price) async {
      if (price != null) {
        await db.insert(
          'Pos_Prices',
          price,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        PosPricesModel pricesModel = PosPricesModel.fromJson(price);
        listPrices.add(pricesModel);
      }
    });
    setWaiting(prices);
    prices = ProviderGeneralState(data: listPrices, hasData: true);
    notifyListeners();
  }

 Future<List<SCTblItemsModel>> getAllItems() async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .query("SC_TblItems");
    return results.map((e)=>SCTblItemsModel.fromMap(e)).toList();
  }
  Future<List<PosTblDealersModel>> getAllDealers() async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("select * from Pos_TblDealers where DealerID is null or DealerID = 0;");
    return results.map((e)=>PosTblDealersModel.fromJson(e)).toList();
  }
  Future<List<AgentModel>> getAgent() async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .query("Pos_TblAgent");
    return results.map((e)=>AgentModel.fromJson(e)).toList();
  }
  Future<List<SCTblItemsModel>> getItemByName(String item) async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        // .query("SC_TblItems",where: 'ItemName like %?%',whereArgs: ['صف']);
        .rawQuery("select * from SC_TblItems where ItemName like '%$item%' or ItemCode like '%$item%';");
    return results.map((e)=>SCTblItemsModel.fromMap(e)).toList();
  }
  Future<List<PosTblDealersModel>> getDealerByName(String dealer) async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("select * from Pos_TblDealers where DealerName like '%$dealer%' or DealerCode like '%$dealer%';");
    return results.map((e)=>PosTblDealersModel.fromJson(e)).toList();
  }
  Future<List<PosTblDealersModel>> getDealerById(String dealer) async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("select * from Pos_TblDealers where Dealerid = '$dealer';");
    return results.map((e)=>PosTblDealersModel.fromJson(e)).toList();
  }

  Future<Iterable<PosTblDealersModel>> getDealerSqliteDealerid(
      String dealer) async {
    final db = await database;
    var results = await db!.rawQuery(
        "select * from Pos_TblDealers where  DealerIDSqlite = '%$dealer%';");
    return results.map((e) => PosTblDealersModel.fromJson(e));
  }
  Future<int> getDealerSqlId() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!
        .rawQuery("select * from Pos_TblDealers order by dealerIDSqlite ;");
    if (result.isEmpty) {
      return 1;
    } else {
      List<PosTblSalesModel> x =
      result.map((e) => PosTblSalesModel.fromJson(e)).toList();
      return x[0].serialIdSqlite + 1;
    }
  }
  Future<List<PosTblBarcodeDtl>> getItemByBarcode(String barcode) async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("select * from Pos_TblBarcodeDtl where barcode = '$barcode';");
    return results.map((e)=>PosTblBarcodeDtl.fromJson(e)).toList();
  }
  Future<List<SCTblItemsModel>> getItemByID(int itemID) async {
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("select * from SC_TblItems where itemID = '$itemID';");
    return results.map((e)=>SCTblItemsModel.fromJson(e)).toList();
  }
  Future<List<FillSearchModel>> getAllItemDataByID(int itemID,int branchID,[int barcodeUnitID = 0,int lang =0]) async {
    var dealerPriceListID =0;
    final db = await database;
    List<Map<String,dynamic>> results = await db!
        .rawQuery("""
        SELECT SC_TblItems.ItemID,case  when $lang = 1 then SC_TblUnits.UnitNameEn else SC_TblUnits.UnitNameAr end  as UnitName,
    SC_TblItem_Units.ConvParm,SC_TblItems.DevSalUnit AS UnitId,SC_TblItems.AvregCost AS ItemPrice
    , SC_TblItemPrices.ItemPrice1,
     SC_TblItems.AvregCost as ItemPrice1M,
     0 AS ItemPrice2,
     0 AS ItemPrice3,Avregcost,
    (CASE WHEN $dealerPriceListID <> 0 THEN $dealerPriceListID ELSE SC_TblItemPrices.PriceId END) AS PriceOrder
    ,CurrentStock, u2.ConvParm as ConvParm_Stock , 0 as DiscVal
    FROM SC_TblItems LEFT JOIN SC_TblItemPrices on SC_TblItems.ItemID = SC_TblItemPrices.ItemId 
    inner JOIN SC_TblItem_Units on
    (case when $barcodeUnitID = 0 then SC_TblItems.DevSalUnit else $barcodeUnitID end) = SC_TblItem_Units.UnitId AND SC_TblItems.ItemID = SC_TblItem_Units.ItemId
    inner JOIN
    SC_TblUnits  on SC_TblUnits.UnitId = SC_TblItem_Units.UnitId  
    left join SC_TblItemStocks on SC_TblItemStocks.ItemId=SC_TblItems.ItemId and (SC_TblItemStocks.BranshId=$branchID or SC_TblItemStocks.BranshId is null)
   inner JOIN SC_TblItem_Units as u2 on SC_TblItems.ItemID = u2.ItemId AND SC_TblItems.DevStockUnit = u2.UnitId
    WHERE     (SC_TblItems.ItemID = $itemID) and SC_TblItemStocks.CurrentStock > 0
    Order by PriceOrder asc""");
    return results.map((e)=>FillSearchModel.fromJson(e)).toList();
  }
  Future<int> getMaxCode() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!
        .rawQuery(
        "select * from Pos_TblSales order by serialIdSqlite desc;");
    if (result.isEmpty) {
      return 1;
    } else {
      List<PosTblSalesModel> x = result.map((e) => PosTblSalesModel.fromJson(e))
          .toList();
      return x[0].serialIdSqlite + 1;
    }
  }
  Future<int?> saveSalesInv(PosTblSalesModel hdr,List<PosTblSalesDtlModel> dtl) async {
    final db = await database;
    final id = await db?.insert('Pos_TblSales', hdr.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    for (var i=0; i < dtl.length; i++) {
      await db?.insert('Pos_TblSalesDtl', dtl[i].toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return id;
  }
  readTableData(String sql) async {
    Database? mydb = await database;
    var response = mydb?.rawQuery(sql);
    return response;
  }

  insertDataInTabl(String sql) async {
    Database? mydb = await database;
    var response = mydb?.rawInsert(sql);
    return response;
  }
}
