import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/features/place_a_add/_controller/place_a_add_controller.dart';

class PropertyTextInputField extends StatefulWidget {
  String hintText;
  TextInputType textType;
  TextEditingController controller;
  bool? optionalText;

  PropertyTextInputField({
    required this.hintText,
    required this.textType,
    required this.controller,
    this.optionalText,
  });

  @override
  _PropertyTextInputFieldState createState() => _PropertyTextInputFieldState();
}

class _PropertyTextInputFieldState extends State<PropertyTextInputField> {
  @override
  Widget build(BuildContext context) {
    Get.put(PlaceAddController());
    //printInfo(info: widget.optionalText.toString());
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.propertyRentTitleRadius)),
          borderSide: BorderSide(width: AppDimension.propertyRentTitleBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blueGrey),
        ),
        hintText: widget.hintText,
        counterStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        suffixText:
            widget.optionalText == true ? AppLanguageString.OPTIONAL.tr : '',
      ),
      keyboardType: widget.textType,
    );
  }
}
