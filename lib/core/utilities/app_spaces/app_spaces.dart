import 'package:flutter/cupertino.dart';

class AppSpaces {
  static Padding spaces_bottom_5 =
      const Padding(padding: EdgeInsets.only(bottom: 5));
  static Padding spaces_height_1 =
      const Padding(padding: EdgeInsets.only(top: 1));
  static Padding spaces_height_2 =
      const Padding(padding: EdgeInsets.only(top: 2));
  static Padding spaces_height_5 =
      const Padding(padding: EdgeInsets.only(top: 5));
  static Padding spaces_height_10 =
      const Padding(padding: EdgeInsets.only(top: 10));
  static Padding spaces_height_15 =
      const Padding(padding: EdgeInsets.only(top: 15));
  static Padding spaces_height_20 =
      const Padding(padding: EdgeInsets.only(top: 20));
  static Padding spaces_height_25 =
      const Padding(padding: EdgeInsets.only(top: 25));
  static Padding spaces_height_30 =
      const Padding(padding: EdgeInsets.only(top: 30));
  static Padding spaces_height_35 =
      const Padding(padding: EdgeInsets.only(top: 35));
  static Padding spaces_height_40 =
      const Padding(padding: EdgeInsets.only(top: 40));
  static Padding spaces_height_50 =
      const Padding(padding: EdgeInsets.only(top: 50));
  static Padding spaces_height_100 =
      const Padding(padding: EdgeInsets.only(top: 100));
  static Padding spaces_height_160 =
      const Padding(padding: EdgeInsets.only(top: 160));

  static Padding spaces_width_5 =
      const Padding(padding: EdgeInsets.only(left: 5));
  static Padding spaces_width_10 =
      const Padding(padding: EdgeInsets.only(left: 10));
  static Padding spaces_width_15 =
      const Padding(padding: EdgeInsets.only(left: 15));
  static Padding spaces_width_20 =
      const Padding(padding: EdgeInsets.only(left: 20));
  static Padding spaces_width_25 =
      const Padding(padding: EdgeInsets.only(left: 25));

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
