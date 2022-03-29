import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: AppColors.backgroundColor,
      errorColor: AppColors.error_color,
      dividerColor: AppColors.borderColor,
      hintColor: AppColors.hintColor,
      textTheme: TextTheme(
        bodyText1: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.b1,
                color: AppColors.textColor,
                letterSpacing: 0.3,
                wordSpacing: 0.5)),
        bodyText2: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.b2,
                color: AppColors.textColor,
                letterSpacing: 0.3,
                wordSpacing: 0.5)),
        headline1: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h1,
                color: AppColors.textColor,
                letterSpacing: 0.3,
                wordSpacing: 0.5)),
        headline2: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h2, color: AppColors.textColor),
            letterSpacing: 0.3,
            wordSpacing: 0.5),
        headline3: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h3, color: AppColors.textColor),
            letterSpacing: 0.3,
            wordSpacing: 0.5),
        headline4: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h4, color: AppColors.textColor),
            letterSpacing: 0.3,
            wordSpacing: 0.5),
        headline5: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h5, color: AppColors.textColor),
            letterSpacing: 0.3,
            wordSpacing: 0.5),
        headline6: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: AppDimension.h6, color: AppColors.textColor),
            letterSpacing: 0.3,
            wordSpacing: 0.5),
      ),
    );
  }
}
