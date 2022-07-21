import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';


final GlobalKey<FormState> formKey= GlobalKey<FormState>();
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
  bool emailisValid = false;

  @override
  Widget build(BuildContext context) {
    emailisValid = EmailValidator.validate(widget.controller.text);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(
            color: AppColors.grey, // set border color
            width: 1.5), // set border width
        borderRadius: const BorderRadius.all(
            Radius.circular(25.0)), // set rounded corner radius
      ),
      child: widget.controller == 'emailController'
          ? TextField(

              style: TextStyle(
                color: AppColors.textColor,
                fontFamily: 'Inter',
                fontSize: 18.0.sp,
              ),
              key: formKey,

              onChanged: (value) {
                setState(() {
                  value == null ? emailisValid = false : emailisValid = true;
                });
              },
              controller: widget.controller,
              decoration: InputDecoration(
                errorText:
                    emailisValid == false ? 'This field is required.' : null,
                border: InputBorder.none,
              ),
              keyboardType: widget.textType,
            )
          : TextField(
              style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.textColor,
                fontSize: 18.0.sp,
              ),
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.labelText,
                hintStyle:  TextStyle(fontSize: 15.sp,fontFamily: 'Inter',),
                border: InputBorder.none,
              ),
              keyboardType: widget.textType,
            ),
    );
  }
}
