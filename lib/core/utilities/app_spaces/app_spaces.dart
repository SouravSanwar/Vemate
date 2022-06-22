import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSpaces {
  static Padding spaces_bottom_5 =
       Padding(padding: EdgeInsets.only(bottom: 5.h));
  static Padding spaces_height_1 =
      Padding(padding: EdgeInsets.only(top: 1.h));
  static Padding spaces_height_2 =
      Padding(padding: EdgeInsets.only(top: 2.h));
  static Padding spaces_height_5 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.007));
  static Padding spaces_height_10 =
      Padding(padding: EdgeInsets.only(top:  Get.height*0.013,));
  static Padding spaces_height_15 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.0209));
  static Padding spaces_height_20 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.02778));
  static Padding spaces_height_25 =
      Padding(padding: EdgeInsets.only(top: Get.height*0.03473));
  static Padding spaces_height_30 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.04167));
  static Padding spaces_height_35 =
      Padding(padding: EdgeInsets.only(top: Get.height*0.048615));
  static Padding spaces_height_40 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.05556));
  static Padding spaces_height_50 =
      Padding(padding: EdgeInsets.only(top: Get.height*0.06945));
  static Padding spaces_height_100 =
       Padding(padding: EdgeInsets.only(top: Get.height*0.13889));
  static Padding spaces_height_160 =
      Padding(padding: EdgeInsets.only(top: 160.h));

  static Padding spaces_width_2 =
      Padding(padding: EdgeInsets.only(left: Get.width *0.00556));
  static Padding spaces_width_5 =
      Padding(padding: EdgeInsets.only(left: Get.width *0.013889));
  static Padding spaces_width_10 =
       Padding(padding: EdgeInsets.only(left: Get.width *0.02778));
  static Padding spaces_width_15 =
      Padding(padding: EdgeInsets.only(left: Get.width *0.04167));
  static Padding spaces_width_20 =
      Padding(padding: EdgeInsets.only(left: Get.width *0.05556));
  static Padding spaces_width_25 =
      Padding(padding: EdgeInsets.only(left: Get.width *0.069449));

  static EdgeInsets spaces_all_5 = const EdgeInsets.all(5);
  static EdgeInsets spaces_all_10 = const EdgeInsets.all(10);
  static EdgeInsets spaces_all_15 = const EdgeInsets.all(15);
  static EdgeInsets spaces_all_20 = const EdgeInsets.all(20);

  static EdgeInsets custom_spaces(
          {double? left, double? right, double? bottom, double? top}) =>
      EdgeInsets.only(
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0);

  static EdgeInsets custom_all_spaces(double space) => EdgeInsets.all(space);
}
