import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/models/AppUpdator.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/main.dart';

class AppUpdate extends ChangeNotifier {
  AppUpdator? appUpdator;
  bool isUpdate = true;

  updateApp() {
    isUpdate = false;
    notifyListeners();
  }

  Future getUpdateInfo() async {
    appUpdator = null;
    final response = await http.get(
      Uri.parse(Urls.appUpdate),
      headers: {
        'Authorization': 'token ${prefs!.getString('token')}',
      },
    );

    var data = json.decode(response.body.toString());

    printInfo(info: 'Update Info: ' + data.toString());

    appUpdator = AppUpdator.fromJson(data);

    notifyListeners();
  }
}
