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
      child: widget.controller == 'emailController'
          ? TextFormField(
              style: TextStyle(color: Colors.white, fontSize: 18.0),
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
                errorText: emailisValid==false? 'This field is required.' : null,
                border: InputBorder.none,
              ),
              keyboardType: widget.textType,
            )
          : TextField(

              style: TextStyle(color: Colors.white, fontSize: 18.0),
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.labelText,
                hintStyle: TextStyle( fontSize: 15),
                border: InputBorder.none,
              ),
              keyboardType: widget.textType,
            ),
    );
  }
}
