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
      Icons.favorite_border,
      'Favourite',
    ],
    [
      Icons.person,
      'Profile',
    ],
  ].obs;

  List<String> names = [
    'Home',
    'Favourite',
    'Profile',
  ].obs;

//RxInt itemCount = bottomBarData!.length.obs;
}
