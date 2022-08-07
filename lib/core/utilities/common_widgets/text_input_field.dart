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
  FormFieldValidator? validator;

  TextInputField({
    required this.labelText,
    required this.height,
    required this.textType,
    required this.controller,
    this.validator
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
      padding: const EdgeInsets.only(left: 15, right: 15),
      color: AppColors.backgroundColor,
      child: widget.controller == 'emailController'
          ? TextFormField(
              validator: widget.validator,
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
          isDense:true,

          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.grey, // set border color
                  width: 1.5
              ),
              borderRadius: BorderRadius.circular(30.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.grey, // set border color
                width: 1.5
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.grey, // set border color
                width: 1.5
            ),
          ),
          hintText: widget.labelText,
          hintStyle:  TextStyle(fontFamily: 'Inter',fontSize: 15.sp),
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.blue,
          ),

        ),

         keyboardType: widget.textType,
            )
          : TextFormField(
              validator: widget.validator,

              style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.textColor,
                fontSize: 18.0.sp,
              ),
              controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
              color: AppColors.grey, // set border color
              width: 1.5
          ),
          borderRadius: BorderRadius.circular(30.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.grey, // set border color
                width: 1.5
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.grey, // set border color
                width: 1.5
            ),
          ),
          hintText: widget.labelText,
          hintStyle:  TextStyle(fontFamily: 'Inter',fontSize: 15.sp),
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.blue,
          ),

        ),
        keyboardType: widget.textType,
            ),
    );
  }
}
