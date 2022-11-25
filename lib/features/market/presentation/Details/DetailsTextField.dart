import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class DetailsTextField extends StatefulWidget {

  TextEditingController controller;
  TextInputType? textType;
  bool? enabled;

  DetailsTextField({
    required this.controller,
   this.textType,
    this.enabled=true
  });

  @override
  _DetailsTextFieldState createState() => _DetailsTextFieldState();
}

class _DetailsTextFieldState extends State<DetailsTextField> {
  bool emailisValid = false;

  @override
  Widget build(BuildContext context) {
    emailisValid = EmailValidator.validate(widget.controller.text);
    return Container(
      color: Colors.transparent,
      child: TextFormField(
        enabled: widget.enabled==false? false : true,
        style: TextStyle(
            color: Colors
                .white
                .withOpacity(
                .7)),
        decoration:
        InputDecoration(
          hintText:
          'Type Text Here',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.7), // set border color
                width: 1.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.7), // set border color
                width: 1.5),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.white.withOpacity(.7), // set border color
                width: 1.5),
          ),
        ),
        controller:widget.controller,
          keyboardType: widget.textType,
      )
    );
  }
}
