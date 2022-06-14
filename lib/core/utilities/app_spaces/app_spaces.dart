import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpaces {
  static Padding spaces_bottom_5 =
       Padding(padding: EdgeInsets.only(bottom: 5.h));
  static Padding spaces_height_1 =
      Padding(padding: EdgeInsets.only(top: 1.h));
  static Padding spaces_height_2 =
      Padding(padding: EdgeInsets.only(top: 2.h));
  static Padding spaces_height_5 =
       Padding(padding: EdgeInsets.only(top: 5.h));
  static Padding spaces_height_10 =
      Padding(padding: EdgeInsets.only(top: 10.h));
  static Padding spaces_height_15 =
       Padding(padding: EdgeInsets.only(top: 15.h));
  static Padding spaces_height_20 =
       Padding(padding: EdgeInsets.only(top: 20.h));
  static Padding spaces_height_25 =
      Padding(padding: EdgeInsets.only(top: 25.h));
  static Padding spaces_height_30 =
       Padding(padding: EdgeInsets.only(top: 30.h));
  static Padding spaces_height_35 =
      Padding(padding: EdgeInsets.only(top: 35.h));
  static Padding spaces_height_40 =
       Padding(padding: EdgeInsets.only(top: 40.h));
  static Padding spaces_height_50 =
      Padding(padding: EdgeInsets.only(top: 50.h));
  static Padding spaces_height_100 =
       Padding(padding: EdgeInsets.only(top: 100.h));
  static Padding spaces_height_160 =
      Padding(padding: EdgeInsets.only(top: 160.h));

  static Padding spaces_width_2 =
      Padding(padding: EdgeInsets.only(left: 2.w));
  static Padding spaces_width_5 =
      Padding(padding: EdgeInsets.only(left: 5.w));
  static Padding spaces_width_10 =
       Padding(padding: EdgeInsets.only(left: 10.w));
  static Padding spaces_width_15 =
      Padding(padding: EdgeInsets.only(left: 15.w));
  static Padding spaces_width_20 =
      Padding(padding: EdgeInsets.only(left: 20.w));
  static Padding spaces_width_25 =
      Padding(padding: EdgeInsets.only(left: 25.w));

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
