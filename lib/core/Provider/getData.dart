import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/models/CheckSetCheck.dart';
import 'package:ketemaa/core/models/CheckWishlistModel.dart';
import 'package:ketemaa/core/models/ComicsModel.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';
import 'package:ketemaa/core/models/SetListModel.dart';
import 'package:ketemaa/core/models/SingleCollectibleModel.dart';
import 'package:ketemaa/core/models/SingleComicModel.dart';
import 'package:ketemaa/core/models/SingleProductModel.dart';
import 'package:ketemaa/core/models/WishListModel.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/main.dart';
import '../models/CollectiblesModel.dart';

class GetData extends ChangeNotifier {
  CollectiblesModel? collectiblesModel;

  ComicsModel? comicsModel;

  SingleProductModel? singleProductModel;

  ProfileModel? profileModel;

  CheckWishlistModel? checkWishlistModel;
  CheckSetCheck? checkSetCheck;

  WishListModel? wishListModel;
  SetListModel? setListModel;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };
  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  Future getUserInfo() async {
    profileModel = null;
    final response = await http.get(
      Uri.parse(Urls.userInfo),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    //printInfo(info: data.toString());

    profileModel = ProfileModel.fromJson(data);

    notifyListeners();
  }

  Future getCollectibles({int offset = 0}) async {
    final response = await http.get(
      Uri.parse(
        Urls.mainUrl +
            '/api/v1/veve/public/products/?type=0&limit=20&offset=$offset',
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    //printInfo(info: data.toString());

    if (collectiblesModel != null) {
      if (offset == 0) collectiblesModel!.results!.clear();

      collectiblesModel!.results!.addAll(CollectiblesModel.fromJson(data).results!);
    } else {
      collectiblesModel = CollectiblesModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getComics({int offset = 0}) async {
    final response = await http.get(
      Uri.parse(
        Urls.mainUrl +
            '/api/v1/veve/public/products/?type=1&limit=20&offset=$offset',
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    //printInfo(info: data.toString());

    if (comicsModel != null) {
      if (offset == 0) comicsModel!.results!.clear();

      comicsModel!.results!.addAll(ComicsModel.fromJson(data).results!);
    } else {
      comicsModel = ComicsModel.fromJson(data);
    }

    notifyListeners();
  }

  Future getSingleProduct(int? id, {int graphType = 0}) async {
    singleProductModel = null;
    final response = await http.get(
      Uri.parse(
        Urls.singleProduct + '$id?graph_type=$graphType',
      ),
      headers: requestToken,
    );

    printInfo(info: Urls.singleProduct + '$id?graph_type=0');

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());

    singleProductModel = SingleProductModel.fromJson(data);

    notifyListeners();
  }

  Future checkWishlist(int id) async {
    checkWishlistModel = null;
    final response = await http.get(
      Uri.parse(
        Urls.checkWishlist + id.toString(),
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());

    checkWishlistModel = CheckWishlistModel.fromJson(data);

    notifyListeners();
  }

  Future checkSetList(int id) async {
    checkSetCheck = null;
    final response = await http.get(
      Uri.parse(
        Urls.checkSet + id.toString(),
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());

    checkSetCheck = CheckSetCheck.fromJson(data);

    notifyListeners();
  }

  Future getWishList() async {
    wishListModel = null;
    final response = await http.get(
      Uri.parse(
        Urls.commonStorage + '?type=1',
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());

    wishListModel = WishListModel.fromJson(data);

    notifyListeners();
  }

  Future getSetList() async {
    setListModel = null;
    final response = await http.get(
      Uri.parse(
        Urls.commonStorage + '?type=0',
      ),
      headers: requestToken,
    );

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());
    setListModel = SetListModel.fromJson(data);

    notifyListeners();
  }
}
