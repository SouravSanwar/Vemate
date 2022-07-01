import 'package:flutter/material.dart';
import 'package:ketemaa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors extends ChangeNotifier {
  static Color primaryColor = const Color(0xffA984E5);
  static Color backgroundColor = Color(0xff02072D);
  static Color lightBackgroundColor = const Color(0xff384362);
  static Color textColor = Colors.white;
  static Color detailsTextColor = Color(0xffD3D3D3);
  static Color detailsTextColor1 = Color(0xffD3D3D3);
  static Color textBoxBgColor = Color(0xff2F3758);

  //static Color categoryCardColor = Color(0xffA984E5);
  static Color? categoryCardColor;
  static Color iconColor = Color(0xff8760EE);
  static Color borderColor = Color(0xff4e4f53).withOpacity(0.2);

  static Color textColorBold = const Color(0xff5c5c5c);

  /*const Color(0xff5e5e5e);*/
  static Color error_color = Colors.red;
  static Color grey = Color(0xff959595);
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
  static Color graphCard= const Color(0xff15193C);
  static Gradient buttonTrue= LinearGradient(
    colors: [
      Color(0xff00A7FF),
      Color(0xff00A7FF),
    ],
  );

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
    //mode = prefs!.getInt('mode');

   /* print('Color Mode Color: ' + mode.toString());*/

    if (mode == 0) {
      //Light Mode
      categoryCardColor = Color(0xff232942);
      primaryColor = const Color(0xff33E4EC);
      backgroundColor = Colors.white;
      textColor = Colors.grey;
      textBoxBgColor = Colors.grey;
      detailsTextColor = Color(0xff070000);
      detailsTextColor1 = Color(0xff979595);
      borderColor = Colors.grey;
      cardGradient = const LinearGradient(
        colors: [
          Color(0xfffdfdfd),
          Color(0xfffdfdfd),
        ],
      );
    } else {
      //Dark Mode
      categoryCardColor = Color(0xffA984E5);
      primaryColor = const Color(0xffA984E5);
      backgroundColor = Color(0xff02072D);
      textColor = Colors.white;
      textBoxBgColor = Color(0xff2F3758);
      detailsTextColor = Color(0xffD3D3D3);
      detailsTextColor1 = Color(0xffD3D3D3);
      borderColor = Color(0xff4e4f53);
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
