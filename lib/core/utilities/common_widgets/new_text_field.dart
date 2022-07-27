import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class NewTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? sicon;
  String? initialValue;
  String? controll;
  int? lines;
  var align;
  bool? isBorder;
  bool? readOnly;


  NewTextField({
    required this.hint,
    this.textEditingController,
    required this.keyboardType,
    this.obscureText = false,
    this.controll,
    this.initialValue,
    this.sicon,
    this.lines,
    this.align,
    this.isBorder = true,
    this.readOnly = false,
  });

  @override
  State<NewTextField> createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<NewTextField> {
  bool? error;

  double _width = 0;
  double _pixelRatio = 0;
  bool large = false;
  bool medium = false;


  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      //elevation: large ? 6 : (medium ? 4 : 2),
      child: Theme(
        data: ThemeData(
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.white,
            border: widget.isBorder == true ? Border.all(color: Colors.black12) : null,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: TextFormField(
            readOnly: widget.readOnly!,
            enabled: true,
            maxLines: widget.lines,
            initialValue: widget.initialValue,
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType,
            cursorColor: AppColors.primaryColor,
            obscureText: widget.obscureText,
            textAlign: widget.align == null ? TextAlign.center : widget.align,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hint,
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: widget.isBorder == true ? AppColors.primaryColor : Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: widget.isBorder == true ? AppColors.primaryColor : Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              setState(() {
                printInfo(info: value.toString());

                if (value!.isEmpty) {
                  error = true;
                } else {
                  error = false;
                }
              });

              print(error);
            },
            onSaved: (String? value) {
              widget.controll = value;
            },
          ),
        ),
      ),
    );
  }
}
