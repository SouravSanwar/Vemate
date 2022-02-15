import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerPageController {
  static ControllerPageController to = Get.find();

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
      Icons.add,
      'Place a Add',
    ],
    [
      Icons.message,
      'Chats',
    ],
    [
      Icons.person,
      'Profile',
    ],
  ].obs;

  List<String> names = [
    'Home',
    'Favourite',
    'Place a Add',
    'Chats',
    'Profile',
  ].obs;

  //RxInt itemCount = bottomBarData!.length.obs;
}
