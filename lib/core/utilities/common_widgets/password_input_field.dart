import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class PasswordInputField extends StatefulWidget {
  String labelText;
  num height;
  TextInputType textType;
  TextEditingController controller;
  FormFieldValidator? validator;

  PasswordInputField({
    required this.labelText,
    required this.height,
    required this.textType,
    required this.controller,
    this.validator
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      color: Colors.transparent,
      child: TextFormField(

        validator: widget.validator,
        enableInteractiveSelection: true,
        style: TextStyle(color: Colors.white, fontSize: 18.0.sp),
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.7), // set border color
                  width: 1.5
              ),
              borderRadius: BorderRadius.circular(25.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.7), // set border color
                width: 1.5
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.7), // set border color
                width: 1.5
            ),
          ),
          hintText: widget.labelText,
          hintStyle: TextStyle(
              color: AppColors.white.withOpacity(.7),
              fontFamily: 'Inter',
              fontSize: 15.sp),
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.blue,
          ),
          suffixIcon: IconButton(

            splashColor: Colors.transparent,
            onPressed: () {
              setState(() {
                _toggleVisibility = !_toggleVisibility;
              });
            },
            icon: _toggleVisibility
                ?  Icon(
                    Icons.visibility,
              color: AppColors.white.withOpacity(.7),
                  )
                :  Icon(
                    Icons.visibility_off,
              color: AppColors.white.withOpacity(.7),
                  ),
          ),
        ),
        obscureText: _toggleVisibility,
      ),
    );
  }
}
