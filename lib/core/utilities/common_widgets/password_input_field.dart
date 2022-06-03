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
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(left: 20,right: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(
            color: AppColors.grey, // set border color
            width: 1.5), // set border width
        borderRadius: const BorderRadius.all(
            Radius.circular(25.0)), // set rounded corner radius
      ),
      child: TextField(

        style: const TextStyle(color: Colors.white,
                         fontSize: 18.0),
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: const TextStyle( fontSize: 15),
            labelStyle:const TextStyle(color: Colors.blue,),
            border: InputBorder.none,
            suffixIcon: IconButton(
              splashColor:AppColors.textColor,
              onPressed: () {
                setState(() {
                  _toggleVisibility = !_toggleVisibility;
                });
              },
              icon: _toggleVisibility
                  ? const Icon(Icons.visibility,
              color: Colors.grey,)
                  : const Icon(Icons.visibility_off,
              color: Colors.grey,),
            )),
        obscureText: _toggleVisibility,
      ),
    );
  }
}
