import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class MintTextField extends StatefulWidget {
  String labelText;
  double? width;
  TextInputType textType;
  TextEditingController controller;
  FormFieldValidator? validator;
  dynamic onsaved;
  dynamic onChanged;
  bool? isEnable;
  FocusNode? focusNode;

  MintTextField({
    required this.labelText,
    this.width,
    required this.textType,
    required this.controller,
    this.validator,
    this.onsaved,
    this.onChanged,
    this.isEnable,
    this.focusNode,
  });

  @override
  _MintTextFieldState createState() => _MintTextFieldState();
}

class _MintTextFieldState extends State<MintTextField> {
  bool emailisValid = false;

  @override
  Widget build(BuildContext context) {
    emailisValid = EmailValidator.validate(widget.controller.text);
    return Container(
      //width: Get.width*.25,
      width: widget.width,
      height: Get.height * .0467,
      color: Colors.transparent,
      child: TextFormField(
        focusNode: widget.focusNode,
        autofocus: false,
        onChanged: widget.onChanged,
        textAlign: TextAlign.center,
        enabled: widget.isEnable,
        onSaved: widget.onsaved,
        validator: widget.validator,
        style: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.white.withOpacity(.7),
          fontSize: 13.0.sp,
        ),
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.7), // set border color
                  width: 1.5),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.3), // set border color
                width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.3), // set border color
                width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.3), // set border color
                width: 1.5),
          ),
          hintText: widget.labelText,
          hintStyle: TextStyle(color: AppColors.white.withOpacity(.7), fontFamily: 'Inter', fontSize: 15.sp),
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
