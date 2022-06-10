import 'package:flutter/material.dart';
import 'package:ketemaa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors extends ChangeNotifier {
  static Color primaryColor = const Color(0xffA984E5);
  static Color? backgroundColor;
  static Color lightBackgroundColor = const Color(0xff384362);
  static Color textColor = Colors.white;
  static Color detailsTextColor = const Color(0xffD3D3D3);
  static Color detailsTextColor1 = const Color(0xffD3D3D3);
  static Color textBoxBgColor = const Color(0xff2F3758);

  static Color? categoryCardColor;
  static Color? iconColor;
  static Color borderColor = const Color(0xff4e4f53);

  static Color textColorBold = const Color(0xff5c5c5c);

  /*const Color(0xff5e5e5e);*/
  static Color error_color = Colors.red;
  static Color grey = const Color(0xff747373);
  static Color blueGrey = Colors.blueGrey;
  static Color hintColor = const Color(0xffA2A2A2);
  static Color white = Colors.white;
  static Color greyWhite = const Color(0xffD3D3D3);
  static Color shadowColor = const Color(0xff213109);
  static Color black = Colors.black;
  static Color displayBottomColor = const Color(0xffF3FFF6);

  static Gradient graphGradientColors = const LinearGradient(
    colors: [
      Color(0xff23b6e6),
      Color(0xff02d31a),
    ],
  );

  static Gradient purpleGradient = const LinearGradient(
    colors: [
      Color(0xff8760EE),
      Color(0xffA984E5),
      Color(0xffad88e8),
    ],
  );

  static Gradient cardGradient = const LinearGradient(
    colors: [
      Color(0xff454F70),
      Color(0xff3F496A),
      Color(0xff374162),
      Color(0xff303B5B),
    ],
  );
  static Gradient vaultCardGradient = const LinearGradient(
    colors: [
      Color(0xff454F70),
      Color(0xff3F496A),
      Color(0xff374162),
      Color(0xff303B5B),
      Color(0xff584D9F),
      Color(0xff393E6B),
    ],
    begin: Alignment.topCenter,
    // end at the bottom
    end: Alignment.bottomCenter,
  );
  static LinearGradient graphGradient = const LinearGradient(
    colors: [
      Color(0xff5E5966),
      Color(0xff385179),
      Color(0xff27477A),
      Color(0xff284479),
    ],
    begin: Alignment.topCenter,
    // end at the bottom
    end: Alignment.bottomCenter,
  );
  static Gradient vaultBarGradient = const LinearGradient(
    colors: [
      Color(0xff454F70),
      Color(0xff3F496A),
      Color(0xff374162),
      Color(0xff303B5B),
      Color(0xff584D9F),
      Color(0xff393E6B),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  switchMode() {
    if (mode == 0) {
      //Light Mode
      categoryCardColor = const Color(0xff232942);
      primaryColor = const Color(0xff33E4EC);
      backgroundColor = Colors.white;
      iconColor = const Color(0xff232942);
      textColor = Colors.grey;
      textBoxBgColor = Colors.grey;
      detailsTextColor = const Color(0xff070000);
      detailsTextColor1 = const Color(0xff979595);
      borderColor = Colors.grey;
      cardGradient = const LinearGradient(
        colors: [
          Color(0xfffdfdfd),
          Color(0xfffdfdfd),
        ],
      );
    } else {
      //Dark Mode
      categoryCardColor = const Color(0xffA984E5);
      primaryColor = const Color(0xffA984E5);
      backgroundColor = const Color(0xff272E49);
      textColor = Colors.white;
      iconColor = Colors.white;
      textBoxBgColor = const Color(0xff2F3758);
      detailsTextColor = const Color(0xffD3D3D3);
      detailsTextColor1 = const Color(0xffD3D3D3);
      borderColor = const Color(0xff4e4f53);
      cardGradient = const LinearGradient(
        colors: [
          Color(0xff454F70),
          Color(0xff3F496A),
          Color(0xff374162),
          Color(0xff303B5B),
        ],
      );
    }
    notifyListeners();
  }
}
