import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class PasswordInputField extends StatefulWidget {
  String labelText;
  num height;
  TextInputType textType;
  TextEditingController controller;

  PasswordInputField({
    required this.labelText,
    required this.height,
    required this.textType,
    required this.controller,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _toggleVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * widget.height,
      margin: EdgeInsets.all(AppDimension.b1),
      padding: EdgeInsets.all(AppDimension.b1),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: AppColors.black, // set border color
            width: 1.5), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.labelText,
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _toggleVisibility = !_toggleVisibility;
                });
              },
              icon: _toggleVisibility
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
            )),
        obscureText: _toggleVisibility,
      ),
    );
  }
}
