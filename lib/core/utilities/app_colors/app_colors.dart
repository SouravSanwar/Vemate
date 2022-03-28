import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xffD690ED);
  static Color backgroundColor = const Color(0xff272E49);
  static Color lightBackgroundColor = const Color(0xff384362);
  static Color textColor =  Colors.black;
  static Color textColorBold = const Color(0xff5c5c5c);
  static Color borderColor = const Color(0xff5e5e5e);

  /*const Color(0xff5e5e5e);*/
  static Color error_color = Colors.red;
  static Color grey = Colors.grey;
  static Color blueGrey = Colors.blueGrey;
  static Color hintColor = const Color(0xffA2A2A2);
  static Color white = Colors.white;
  static Color greyWhite = const Color(0xffD3D3D3);
  static Color shadowColor = const Color(0xff213109);
  static Color black = Colors.black;
  static Color displayBottomColor = const Color(0xffF3FFF6);
  static Color quantity_card_color = const Color(0xffA1D853);
  static Color buy_button_color = const Color(0xff578811);
  static Color divider_color = const Color(0xff81878d);

  static Gradient purpleGradient=const LinearGradient(
    colors: [
      Color(0xff8760EE),
      Color(0xffA984E5),
      Color(0xffCA88E8),
    ],
  );

  static Gradient cardGradient=const LinearGradient(
    colors: [
      Color(0xff454F70),
      Color(0xff3F496A),
      Color(0xff374162),
      Color(0xff303B5B),
    ],
  );
  static Gradient vaultBarGradient=const LinearGradient(
    colors: [
      Color(0xff454F70),
      Color(0xff3F496A),
      Color(0xff374162),
      Color(0xff303B5B),
      const Color(0xff584D9F),
      const Color(0xff393E6B),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
