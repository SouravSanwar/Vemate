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
import 'package:ketemaa/core/models/HomeVaultModel.dart';
import 'package:ketemaa/core/models/NewsModel.dart';
import 'package:ketemaa/core/models/NotificationListModel.dart';
import 'package:ketemaa/core/models/NotificationReadModel.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/core/models/SearchCollectiblesModel.dart';
import 'package:ketemaa/core/models/SearchComicsModel.dart';
import 'package:ketemaa/core/models/SetListModel.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/models/VaultStatusModel.dart';
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
  HomeVaultModel? homeVaultModel;

  NewsModel? newsModel;

  AlertModel? alertModel;

  NotificationListModel? notificationListModel;
  NotificationReadModel? notificationReadModel;

  Future getUserInfo() async {
    profileModel = null;

    final response = await BaseClient().get(Urls.userInfo).catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: 'getUserInfo: ' + data.toString());

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
    //printInfo(info: data.toString());

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

    printInfo(info: data.toString());

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

  Future getSingleProduct(int? id, {int graphType = 0}) async {
    singleProductModel = null;
    final response = await BaseClient().get(Urls.singleProduct + '$id?graph_type=$graphType').catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: data.toString());
    singleProductModel = SingleProductModel.fromJson(data);
    notifyListeners();
  }

  Future checkWishlist(int id) async {
    checkWishlistModel = null;
    final response = await BaseClient().get(Urls.checkWishlist + id.toString()).catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: data.toString());

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

    printInfo(info: data.toString());

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

  Future getSetList(String? type) async {
    setListModel = null;
    final response = await BaseClient().get(Urls.commonStorage + '?type=0&$type').catchError(handleError);

    var data = json.decode(response.toString());

    setListModel = SetListModel.fromJson(data);

    printInfo(info: 'Set Info: ' + setListModel!.setResults!.length.toString());

    notifyListeners();
  }

  Future getVaultStats({int graphType = 0}) async {
    vaultStatsModel = null;
    final response = await BaseClient().get(Urls.vaultStats + '?graph_type=$graphType').catchError(handleError);

    printInfo(info: Urls.vaultStats + '?graph_type=$graphType');

    var data = json.decode(response.toString());

    printInfo(info: data.toString());
    vaultStatsModel = VaultStatsModel.fromJson(data);

    notifyListeners();
  }

  Future getHomeVault({int graphType = 0}) async {
    homeVaultModel = null;
    final response = await BaseClient().get(Urls.homeVault + '?graph_type=$graphType').catchError(handleError);

    printInfo(info: Urls.homeVault + '?graph_type=$graphType');

    var data = json.decode(response.toString());

    printInfo(info: data.toString());
    homeVaultModel = HomeVaultModel.fromJson(data);

    notifyListeners();
  }

  Future getNews() async {
    newsModel = null;
    final response = await BaseClient().get(Urls.news).catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: data.toString());
    newsModel = NewsModel.fromJson(data);

    notifyListeners();
  }

  Future getAlert() async {
    alertModel = null;
    final response = await BaseClient().get(Urls.alertList).catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: data.toString());

    alertModel = AlertModel.fromJson(data);

    notifyListeners();
  }

  Future getNotification({int offset = 0}) async {
    final response = await BaseClient().get(Urls.notification + '?limit=20&offset=$offset').catchError(handleError);

    var data = json.decode(response.toString());

    printInfo(info: data.toString());

    if (notificationListModel != null) {
      if (offset == 0) notificationListModel!.results!.clear();

      notificationListModel!.results!.addAll(NotificationListModel.fromJson(data).results!);
    } else {
      notificationListModel = NotificationListModel.fromJson(data);
    }

    notifyListeners();
  }
}
