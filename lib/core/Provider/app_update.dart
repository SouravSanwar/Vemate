import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/models/AppUpdator.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/main.dart';

import '../functions/version_control.dart';

class AppUpdate extends ChangeNotifier {
  AppUpdatorForAndroid? appUpdator;
  bool isUpdate = true;
  bool isNewUpdateAvailable = false;

  updateApp() {
    isUpdate = false;
    notifyListeners();
  }

  Future getUpdateInfo() async {
    appUpdator = null;
    final response = await http.get(
      Uri.parse(Urls.appUpdate + '?os=$os'),
      headers: {
        'Authorization': 'token ${prefs!.getString('token')}',
      },
    );

    var data = json.decode(response.body.toString());

    printInfo(info: 'Update Info: ' + data.toString());

    appUpdator = AppUpdatorForAndroid.fromJson(data);
    isNewUpdateAvailable =
        await _isHigherThanCurrentVersion("${appUpdator!.version}", VersionControl.packageInfo.version);

    notifyListeners();
  }

  Future<bool> _isHigherThanCurrentVersion(String newVersion, String currentVersion) async {
    var isHigher = false;

    try {
      final currentVSegments = currentVersion.split('.');
      final newVSegments = newVersion.split('.');
      final maxLength = max(currentVSegments.length, newVSegments.length);
      for (var i = 0; i < maxLength; i++) {
        final newVSegment = i < newVSegments.length ? int.parse(newVSegments[i]) : 0;
        final currentVSegment = i < currentVSegments.length ? int.parse(currentVSegments[i]) : 0;
        isHigher = newVSegment > currentVSegment;
        if (newVSegment != currentVSegment) {
          break;
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return isHigher;
  }
}
