import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUpdate extends ChangeNotifier {
  bool isUpdate = true;

  updateApp() {
    isUpdate = false;
    notifyListeners();
  }
}
