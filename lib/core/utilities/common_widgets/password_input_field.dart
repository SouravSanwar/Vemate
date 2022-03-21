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
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xff2F3758),
        border: Border.all(
            color: AppColors.grey, // set border color
            width: 1.5), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(25.0)), // set rounded corner radius
      ),
      child: TextField(

        style: TextStyle(color: Colors.white,
                         fontSize: 18.0),
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: TextStyle( fontSize: 15),
            labelStyle:TextStyle(color: Colors.blue,),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _toggleVisibility = !_toggleVisibility;
                });
              },
              icon: _toggleVisibility
                  ? Icon(Icons.visibility,
              color: Color(0xffA984E5),)
                  : Icon(Icons.visibility_off,
              color: Color(0xffA984E5),),
            )),
        obscureText: _toggleVisibility,
      ),
    );
  }
}
