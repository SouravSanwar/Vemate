import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class TextInputField extends StatefulWidget {
  String labelText;
  num height;
  TextInputType textType;
  TextEditingController controller;

  TextInputField({
    required this.labelText,
    required this.height,
    required this.textType,
    required this.controller,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _formKey = GlobalKey<FormState>();
  bool emailisValid = false;

  @override
  Widget build(BuildContext context) {
    emailisValid = EmailValidator.validate(widget.controller.text);
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
      child: widget.controller == 'emailController'
          ? TextFormField(
        key: _formKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            value == null ? emailisValid = false : emailisValid = true;
          });
        },
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.labelText,
          border: InputBorder.none,
        ),
        keyboardType: widget.textType,
      )
          : TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.labelText,
          border: InputBorder.none,
        ),
        keyboardType: widget.textType,
      ),
    );
  }
}