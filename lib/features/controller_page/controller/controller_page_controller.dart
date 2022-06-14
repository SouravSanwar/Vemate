import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerPageController {
  static ControllerPageController to = Get.find();
  Rx<int> currentPage = 0.obs;
  late RxList<List<Object>>? bottomBarData = [
    [
      Icons.home,
      'Home',
    ],
    [
      Icons.shop,
      'Market',
    ],
    [
      Icons.card_travel,
      'My Vault',
    ],
  ].obs;
}
