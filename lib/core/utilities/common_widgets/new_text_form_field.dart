import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class NewTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;
  final Widget? sicon;
  String? initialValue;
  String? controll;
  final bool? isPassword;

  NewTextField({
    required this.hint,
    this.textEditingController,
    required this.keyboardType,
    required this.icon,
    this.obscureText = false,
    this.controll,
    this.initialValue,
    this.sicon,
    this.isPassword,
  });

  @override
  State<NewTextField> createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<NewTextField> {
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        cursorColor: AppColors.primaryColor,
        obscureText: _toggleVisibility,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          isDense: true,
          //labelText: widget.hint,
          //prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),

          suffixIcon: widget.isPassword == true
              ? IconButton(
                  splashColor: const Color(0xff2F3758),
                  onPressed: () {
                    setState(() {
                      _toggleVisibility = !_toggleVisibility;
                    });
                  },
                  icon: _toggleVisibility
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                )
              : null,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please Enter Your ' + widget.controll!;
          } else {
            return null;
          }
        },
        onSaved: (String? value) {
          widget.controll = value;
        },
      ),
    );
  }
}
