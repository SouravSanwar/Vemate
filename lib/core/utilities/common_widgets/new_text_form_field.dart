import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class NewTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;
  final Widget? sicon;
  String? initialValue;
  String? controll;
  double _width = 0;
  double _pixelRatio = 0;
  bool large = false;
  bool medium = false;

  NewTextField({
    required this.hint,
    this.textEditingController,
    required this.keyboardType,
    required this.icon,
    this.obscureText = false,
    this.controll,
    this.initialValue,
    this.sicon,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              // changes position of shadow
            ),
          ],
        ),
        child: TextFormField(
          initialValue: initialValue,
          controller: textEditingController,
          keyboardType: keyboardType,
          cursorColor: AppColors.primaryColor,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            isDense: true,
            labelText: hint,
            prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            suffixIcon: sicon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.0,
              ),
            ),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please Enter Your ' + hint!;
            } else {
              return null;
            }
          },
          onSaved: (String? value) {
            controll = value;
          },
        ),
      ),
    );
  }
}
