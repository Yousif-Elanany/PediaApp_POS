class SqliteScript {
  List<String> createScripts = <String>[
    'CREATE TABLE SC_TblItems (ItemID INTEGER,ItemCode TEXT,ItemName TEXT,CatID INTEGER,CatName TEXT,ItemType INTEGER,DevSalUnit INTEGER,UnitName TEXT,ExpDate INTEGER,StartCost NUMERIC,AvregCost NUMERIC,LastCost NUMERIC,MesureCost NUMERIC,CreditYN INTEGER,GrpPriceID INTEGER,DevStockUnit INTEGER, ItemSerial INTEGER, VatCase INTEGER,Tax1 NUMERIC, Tax2 NUMERIC, Tax3 NUMERIC)',
    'CREATE TABLE SC_TblItem_Units (ItemID INTEGER,UnitId INTEGER,RecId INTEGER,ConvParm NUMERIC,UnitName TEXT)',
    'CREATE TABLE SC_TblItemStocks (ItemID INTEGER,BranshId INTEGER,CurrentStock NUMERIC,ExpDate TEXT,BatchNo TEXT)',
    'CREATE TABLE Pos_Prices (PriceId INTEGER,PriceDisc TEXT,SaleDef INTEGER,PurDef INTEGER)',
    'CREATE TABLE SC_TblUnits (UnitId INTEGER,UnitNameAr TEXT,UnitNameEn TEXT)',
    'CREATE TABLE Pos_TblBarcodeDtl (unitId INTEGER,itemId INTEGER,barcode TEXT,codeDtl TEXT)',
    'CREATE TABLE Pos_TblAgent (AgentDirc INTEGER, AgentType INTEGER, MainAgentId INTEGER, CompanyId INTEGER, BranchID INTEGER, RegionID INTEGER, UserID INTEGER, BoxAcc INTEGER, GlRefID INTEGER,  AgentlID INTEGER,  SuperVID INTEGER, VizaID INTEGER)',
    'CREATE TABLE SC_TblItemPrices (ItemId INTEGER,BranshId INTEGER,PriceId INTEGER,ItemPrice1 NUMERIC,ItemDisc1 NUMERIC,AddPrice NUMERIC)',
    'CREATE TABLE Pos_TblDealers (DealerID INTEGER,StoreId INTEGER,DealerCode TEXT,DealerName TEXT,GlRefID INTEGER,GlRefCode TEXT,DealerCat TEXT,SalPriceID INTEGER,PriceListID INTEGER,AllowCredit INTEGER,CreditLimit NUMERIC,AgentID INTEGER,RegionID INTEGER,Mobile Text,Address Text,Segel Text,TaxCard Text,DealerIDSqlite INTEGER)',
    'CREATE TABLE MG_TblDocs (DocId INTEGER,DocName TEXT,DocSymbol TEXT,DocStart INTEGER,AutoSerial INTEGER,DocType INTEGER,DirType INTEGER,RsvStock INTEGER, Stock INTEGER, StockWay INTEGER, UnderOut INTEGER, Cost INTEGER,CopyN INTEGER,PricePlane_Doc INTEGER)',
    'CREATE TABLE Pos_TblSales (serialUser INTEGER,docType INTEGER,docOn INTEGER,docOnID INTEGER,payKind INTEGER,docDocNo INTEGER,dealerId INTEGER,docTotal NUMERIC,discV NUMERIC,discP NUMERIC,totAdd NUMERIC,totDisc NUMERIC,totItemDisc NUMERIC,docNetPrice NUMERIC,docCash NUMERIC,refNo Text,userCreate INTEGER,createDate TEXT,agentId INTEGER,userMod INTEGER,modDate TEXT,userPrint INTEGER,printDate TEXT,printCount INTEGER,docDate TEXT,docCase INTEGER,note TEXT,serialID INTEGER,serialIdSqlite INTEGER,monyCash NUMERIC,DealerIDSqlite INTEGER)',
    'CREATE TABLE Pos_TblSalesDtl (serialId INTEGER,recId INTEGER,serialIdSqlite INTEGER,codeDtl TEXT,branchIdDtl INTEGER,barCode TEXT,itemId INTEGER,quantity NUMERIC,stockQuantity NUMERIC,unitId INTEGER,convParm NUMERIC,itemCost NUMERIC,itemPrice NUMERIC,itemCprice NUMERIC,totalCost NUMERIC,discPDtl NUMERIC,discvDtl NUMERIC,totDiscDtl NUMERIC,totAddDtl NUMERIC,netPrice NUMERIC,invDistDisc NUMERIC,invDistTotDisc NUMERIC,invDistTotAdd NUMERIC,priceID INTEGER,salesDtlNote TEXT,discPDtl2 NUMERIC,discPDtl3 NUMERIC,totAddDtl2 NUMERIC,totAddDtl3 NUMERIC,totalPrice NUMERIC,taxDtl1 NUMERIC,taxDtl2 NUMERIC,taxDtl3 NUMERIC,taxDtlval1 NUMERIC,taxDtlval2 NUMERIC,taxDtlval3 NUMERIC,itemName TEXT,unitName TEXT)',
    'CREATE TABLE AgentBox (Credit NUMERIC,Debit NUMERIC,Note TEXT)',
  ];
}
