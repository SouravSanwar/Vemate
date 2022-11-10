import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/AlertModel.dart';
import 'package:ketemaa/core/models/BrandModel.dart';
import 'package:ketemaa/core/models/CheckSetCheck.dart';
import 'package:ketemaa/core/models/CheckWishlistModel.dart';
import 'package:ketemaa/core/models/ComicsModel.dart';
import 'package:ketemaa/core/models/Graphs/one_day_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/one_year_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/seven_day_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/sixty_day_graph_model.dart';
import 'package:ketemaa/core/models/Graphs/thirty_day_graph_model.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph1Y.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph30D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph60D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultGraph7D.dart';
import 'package:ketemaa/core/models/HomeVaultGraphs/HomeVaultModel.dart';
import 'package:ketemaa/core/models/MAOModel.dart';
import 'package:ketemaa/core/models/MySetsModel.dart';
import 'package:ketemaa/core/models/NewsModel.dart';
import 'package:ketemaa/core/models/NotificationListModel.dart';
import 'package:ketemaa/core/models/NotificationReadModel.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/core/models/SearchCollectiblesModel.dart';
import 'package:ketemaa/core/models/SearchComicsModel.dart';
import 'package:ketemaa/core/models/SetListModel.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel1Y.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel30D.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel60D.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel7D.dart';
import 'package:ketemaa/core/models/VaultProductDetailsModel.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:ketemaa/core/network/base_client.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/main.dart';
import 'package:ketemaa/core/network/base_controller.dart';
import '../models/CollectiblesModel.dart';

class GetData extends ChangeNotifier with BaseController {
  CollectiblesModel? collectiblesModel;
  SearchCollectiblesModel? searchCollectiblesModel;

  ComicsModel? comicsModel;
  SearchComicsModel? searchComicsModel;

  BrandModel? brandModel;

  SingleProductModel? singleProductModel;
  OneDayGraphModel? oneDayGraphModel;
  SevenDayGraphModel? sevenDayGraphModel;
  ThirtyDayGraphModel? thirtyDayGraphModel;
  SixtyDayGraphModel? sixtyDayGraphModel;
  OneYearGraphModel? oneYearGraphModel;

  ProfileModel? profileModel;

  CheckWishlistModel? checkWishlistModel;
  CheckSetCheck? checkSetCheck;

  WishListModel? wishListModel;
  SetListModel? setListModel;

  VaultStatsModel? vaultStatsModel;
  VaultStatsModel7D? vaultStatsModel7D;
  VaultStatsModel30D? vaultStatsModel30D;
  VaultStatsModel60D? vaultStatsModel60D;
  VaultStatsModel1Y? vaultStatsModel1Y;

  HomeVaultModel? homeVaultModel;
  HomeVaultModel7D? homeVaultModel7D;
  HomeVaultModel30D? homeVaultModel30D;
  HomeVaultModel60D? homeVaultModel60D;
  HomeVaultModel1Y? homeVaultModel1Y;

  NewsModel? newsModel;

  AlertModel? alertModel;

  NotificationListModel? notificationListModel;
  NotificationReadModel? notificationReadModel;
  MaoModel? maoModel;
  MySetsModel? mySetsModel;

  VaultProductDetailsModel? vaultProductDetailsModel;

  Future getVaultProductDetails(int? id, int? type) async {
    vaultProductDetailsModel = null;

    final response = await BaseClient().get(Urls.productMAO + '?type=$type&product=$id').catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: 'getUserInfo: ' + data.toString());

    vaultProductDetailsModel = VaultProductDetailsModel.fromJson(data);

    notifyListeners();
  }

  Future getUserInfo() async {
    profileModel = null;

    final response = await BaseClient().get(Urls.userInfo).catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: 'getUserInfo: ' + data.toString());

    profileModel = ProfileModel.fromJson(data);

    notifyListeners();
  }

  setTheme(int? mode) {
    prefs!.setInt('mode', mode!);

    print('Color Mode Get: ' + mode.toString());
    notifyListeners();
  }

  clearData() {
    profileModel = null;
    vaultStatsModel = null;
    wishListModel = null;
    setListModel = null;

    notifyListeners();
  }

  Future getCollectibles(
      {int offset = 0, int limit = 20, String? keyword = '', String rarity = '', String? mint_number = ''}) async {
    keyword = Uri.encodeComponent(keyword!);
    final response = await BaseClient()
        .get(Urls.mainUrl +
            '/api/v1/veve/public/products/?type=0&limit=$limit&offset=$offset&rarity=$rarity&name=$keyword&mint_number=$mint_number')
        .catchError(handleError);

    var data = json.decode(response.toString());
    ////printInfo(info: data.toString());

    if (collectiblesModel != null) {
      if (offset == 0) collectiblesModel!.results!.clear();

      collectiblesModel!.results!.addAll(CollectiblesModel.fromJson(data).results!);
    } else {
      collectiblesModel = CollectiblesModel.fromJson(data);
    }

    notifyListeners();
  }

  Future searchCollectibles({String keyWord = '', String rarity = '', int offset = 0}) async {
    final response = await BaseClient()
        .get(Urls.mainUrl + '/api/v1/veve/public/products/?type=0&limit=20&offset=$offset&rarity=$rarity&name=$keyWord')
        .catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: data.toString());

    if (searchCollectiblesModel != null) {
      if (offset == 0) searchCollectiblesModel!.results!.clear();

      searchCollectiblesModel!.results!.addAll(SearchCollectiblesModel.fromJson(data).results!);
    } else {
      searchCollectiblesModel = SearchCollectiblesModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getComics({int offset = 0, String? keyword = '', String rarity = '', String? mint_number = ''}) async {
    //keyword = keyword!.replaceAll('#', '%23');
    keyword = Uri.encodeComponent(keyword!);
    final response = await BaseClient()
        .get(Urls.comic + '$offset&rarity=$rarity&name=$keyword&mint_number=$mint_number')
        .catchError(handleError);

    var data = json.decode(response.toString());

    if (comicsModel != null) {
      if (offset == 0) comicsModel!.results!.clear();

      comicsModel!.results!.addAll(ComicsModel.fromJson(data).results!);
    } else {
      comicsModel = ComicsModel.fromJson(data);
    }

    notifyListeners();
  }

  Future searchComics({String keyWord = '', String rarity = '', int offset = 0, String mint_number = ''}) async {
    final response = await BaseClient()
        .get(Urls.mainUrl +
            '/api/v1/veve/public/products/?type=1&limit=20&offset=$offset&rarity=$rarity&name=$keyWord&mint_number=$mint_number')
        .catchError(handleError);

    var data = json.decode(response.toString());

    if (searchComicsModel != null) {
      if (offset == 0) searchComicsModel!.results!.clear();

      searchComicsModel!.results!.addAll(SearchComicsModel.fromJson(data).results!);
    } else {
      searchComicsModel = SearchComicsModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getBrand({int offset = 0}) async {
    final response = await BaseClient().get(Urls.brand + '$offset').catchError(handleError);

    var data = json.decode(response.toString());

    if (brandModel != null) {
      if (offset == 0) brandModel!.results!.clear();

      brandModel!.results!.addAll(BrandModel.fromJson(data).results!);
    } else {
      brandModel = BrandModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getSingleProductGraphs(int? id) async {
    oneDayGraphModel = null;
    sevenDayGraphModel = null;
    thirtyDayGraphModel = null;
    sixtyDayGraphModel = null;
    oneYearGraphModel = null;

    final response1 = await BaseClient().get(Urls.singleProduct + '$id?graph_type=0').catchError(handleError);
    var data1 = json.decode(response1.toString());
    oneDayGraphModel = OneDayGraphModel.fromJson(data1);

    final response2 = await BaseClient().get(Urls.singleProduct + '$id?graph_type=1').catchError(handleError);
    var data2 = json.decode(response2.toString());
    sevenDayGraphModel = SevenDayGraphModel.fromJson(data2);

    final response3 = await BaseClient().get(Urls.singleProduct + '$id?graph_type=2').catchError(handleError);
    var data3 = json.decode(response3.toString());
    thirtyDayGraphModel = ThirtyDayGraphModel.fromJson(data3);

    final response4 = await BaseClient().get(Urls.singleProduct + '$id?graph_type=3').catchError(handleError);
    var data4 = json.decode(response4.toString());
    sixtyDayGraphModel = SixtyDayGraphModel.fromJson(data4);

    final response5 = await BaseClient().get(Urls.singleProduct + '$id?graph_type=4').catchError(handleError);
    var data5 = json.decode(response5.toString());
    oneYearGraphModel = OneYearGraphModel.fromJson(data5);

    notifyListeners();
  }

  Future getHomeVault({int graphType = 0}) async {
    homeVaultModel = null;
    homeVaultModel7D = null;
    homeVaultModel30D = null;
    homeVaultModel60D = null;
    homeVaultModel1Y = null;

    final response = await BaseClient().get(Urls.homeVault + '?graph_type=0').catchError(handleError);
    var data = json.decode(response.toString());
    homeVaultModel = HomeVaultModel.fromJson(data);

    final response1 = await BaseClient().get(Urls.homeVault + '?graph_type=1').catchError(handleError);
    var data1 = json.decode(response1.toString());
    homeVaultModel7D = HomeVaultModel7D.fromJson(data1);

    final response2 = await BaseClient().get(Urls.homeVault + '?graph_type=2').catchError(handleError);
    var data2 = json.decode(response2.toString());
    homeVaultModel30D = HomeVaultModel30D.fromJson(data2);

    final response3 = await BaseClient().get(Urls.homeVault + '?graph_type=3').catchError(handleError);
    var data3 = json.decode(response3.toString());
    homeVaultModel60D = HomeVaultModel60D.fromJson(data3);

    final response4 = await BaseClient().get(Urls.homeVault + '?graph_type=4').catchError(handleError);
    var data4 = json.decode(response4.toString());
    homeVaultModel1Y = HomeVaultModel1Y.fromJson(data4);

    notifyListeners();
  }

  Future getVaultStats({int graphType = 0}) async {
    vaultStatsModel = null;
    vaultStatsModel7D = null;
    vaultStatsModel30D = null;
    vaultStatsModel60D = null;
    vaultStatsModel1Y = null;
    final response = await BaseClient().get(Urls.vaultStats + '?graph_type=0').catchError(handleError);
    var data = json.decode(response.toString());
    vaultStatsModel = VaultStatsModel.fromJson(data);

    final response1 = await BaseClient().get(Urls.vaultStats + '?graph_type=1').catchError(handleError);
    var data1 = json.decode(response1.toString());
    vaultStatsModel7D = VaultStatsModel7D.fromJson(data1);

    final response2 = await BaseClient().get(Urls.vaultStats + '?graph_type=2').catchError(handleError);
    var data2 = json.decode(response2.toString());
    vaultStatsModel30D = VaultStatsModel30D.fromJson(data2);

    final response3 = await BaseClient().get(Urls.vaultStats + '?graph_type=3').catchError(handleError);
    var data3 = json.decode(response3.toString());
    vaultStatsModel60D = VaultStatsModel60D.fromJson(data3);

    final response4 = await BaseClient().get(Urls.vaultStats + '?graph_type=4').catchError(handleError);
    var data4 = json.decode(response4.toString());
    vaultStatsModel1Y = VaultStatsModel1Y.fromJson(data4);

    notifyListeners();
  }

  Future getSingleProduct(int? id, {int graphType = 0}) async {
    singleProductModel = null;
    final response = await BaseClient().get(Urls.singleProduct + '$id?graph_type=$graphType').catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: data.toString());
    singleProductModel = SingleProductModel.fromJson(data);
    notifyListeners();
  }

  Future checkWishlist(int id) async {
    checkWishlistModel = null;
    final response = await BaseClient().get(Urls.checkWishlist + id.toString()).catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: data.toString());

    checkWishlistModel = CheckWishlistModel.fromJson(data);

    notifyListeners();
  }

  Future checkSetList(int id) async {
    checkSetCheck = null;
    final response = await BaseClient().get(Urls.checkSet + id.toString()).catchError(handleError);

    var data = json.decode(response.toString());

    checkSetCheck = CheckSetCheck.fromJson(data);

    notifyListeners();
  }

  Future getWishList({int offset = 0}) async {
    final response =
        await BaseClient().get(Urls.commonStorage + '?type=1&limit=20&offset=$offset').catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: data.toString());

    if (wishListModel != null) {
      if (offset == 0) wishListModel!.results!.clear();

      wishListModel!.results!.addAll(WishListModel.fromJson(data).results!);
    } else {
      wishListModel = WishListModel.fromJson(data);
    }

    notifyListeners();
  }

  removeWish(int index) {
    wishListModel!.results!.removeAt(index);

    notifyListeners();
  }

  Future getSetList(String? type, {int offset = 0}) async {
    final response =
        await BaseClient().get(Urls.commonStorage + '?type=0&limit=20&offset=$offset').catchError(handleError);

    var data = json.decode(response.toString());

    if (setListModel != null) {
      if (offset == 0) setListModel!.setResults!.clear();

      setListModel!.setResults!.addAll(SetListModel.fromJson(data).setResults!);
    } else {
      setListModel = SetListModel.fromJson(data);
    }

    //printInfo(info: 'Set Info: ' + setListModel!.setResults!.length.toString());

    notifyListeners();
  }

  Future getNews() async {
    newsModel = null;
    final response = await BaseClient().get(Urls.news).catchError(handleError);

    var data = json.decode(response.toString());

    //printInfo(info: data.toString());
    newsModel = NewsModel.fromJson(data);

    notifyListeners();
  }

  Future getAlert({int offset = 0}) async {
    final response = await BaseClient().get(Urls.alertList + '?limit=20&offset=$offset').catchError(handleError);

    var data = json.decode(response.toString());

    if (alertModel != null) {
      if (offset == 0) alertModel!.results!.clear();

      alertModel!.results!.addAll(AlertModel.fromJson(data).results!);
    } else {
      alertModel = AlertModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getNotification({int offset = 0}) async {
    final response = await BaseClient().get(Urls.notification + '?limit=20&offset=$offset').catchError(handleError);

    var data = json.decode(response.toString());

    if (notificationListModel != null) {
      if (offset == 0) notificationListModel!.results!.clear();

      notificationListModel!.results!.addAll(NotificationListModel.fromJson(data).results!);
    } else {
      notificationListModel = NotificationListModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getMAO(String? type, String? productID, {int offset = 0}) async {
    final response = await BaseClient()
        .get(Urls.productMAO + '?type=$type&product=$productID&limit=10&offset=$offset')
        .catchError(handleError);

    var data = json.decode(response.toString());

    if (maoModel != null) {
      if (offset == 0) maoModel!.results!.clear();

      maoModel!.results!.addAll(MaoModel.fromJson(data).results!);
    } else {
      maoModel = MaoModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getMySets(int? type, bool unique,{bool graph_data=false})
  async {
    final response = await BaseClient()
        .get(Urls.mySets + '?type=$type&unique=$unique&graph_data=$graph_data')
        .catchError(handleError);

    var data = json.decode(response.toString());

      mySetsModel = MySetsModel.fromJson(data);


    notifyListeners();
  }
  Future getMySets1(int? type,int? productID, bool single,{bool graph_data=false})
  async {
    final response = await BaseClient()
        .get(Urls.mySets + '?type=$type&product=$productID&single=$single&graph_data=$graph_data')
        .catchError(handleError);

    var data = json.decode(response.toString());

    mySetsModel = MySetsModel.fromJson(data);


    notifyListeners();
  }
  Future geSeparatetMySets(int? type, bool unique,bool graph_data,int? product__type)
  async {
    final response = await BaseClient()
        .get(Urls.mySets + '?type=$type&unique=$unique&graph_data=$graph_data&product__type=$product__type')
        .catchError(handleError);

    var data = json.decode(response.toString());

    mySetsModel = MySetsModel.fromJson(data);


    notifyListeners();
  }
}
