import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/utilities/urls/urls.dart';
import '../models/Collectibles.dart';

class GetData extends ChangeNotifier {
  Collectibles? collectibles;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'X-Authorization': '',
  };

  Future getCollectibles() async {
    collectibles = null;
    final response = await http.get(
        Uri.parse(
          Urls.collectibles,
        ),);

    var data = json.decode(response.body.toString());

    printInfo(info: data.toString());

    collectibles = Collectibles.fromJson(data);

    notifyListeners();
  }
}
