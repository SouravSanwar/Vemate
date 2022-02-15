import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppDimension.b1),
      height: Get.height * .09,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.textColor, // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          AppLanguageString.SIGN_UP.tr.toUpperCase(),
          style: Get.textTheme.bodyText1!.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}