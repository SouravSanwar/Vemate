import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class DesignHelper extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onPressed;

  DesignHelper({required this.onPressed, required this.child});

  @override
  _DesignHelperState createState() => _DesignHelperState();
}

class _DesignHelperState extends State<DesignHelper> {
  @override
  void initState() {
    _color = Colors.green;
    super.initState();
  }

  late Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width * .2,
        height: Get.height * .05,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient, // set border width
          borderRadius: const BorderRadius.all(
              Radius.circular(20.0)), // set rounded corner radius
        ),
        child: MaterialButton(
          child: widget.child,
          onPressed: () {
            widget.onPressed();
          },
        ));
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final IconData? data1;
  final String? hintText;
  bool? input = true;
  bool? isObsecre = true;
  bool? enabled = true; //user location

  CustomTextField({
    this.controller,
    this.data,
    this.data1,
    this.hintText,
    this.input,
    this.isObsecre,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          prefixIcon: Icon(
            data,
            color: Colors.green,
          ),
          suffixIcon: IconButton(
            color: Colors.green,
            onPressed: () {
              isObsecre = !isObsecre!;
            },
            icon: Icon(data1),
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}

//For Items of graphn page
class ItemDetails extends StatelessWidget {
  final String? text;
  final String? text1;

  ItemDetails({
    this.text,
    this.text1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: AppColors.cardGradient,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                child: Text(
                  text!,
                  style: TextStyle(
                      color: AppColors.greyWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.purpleGradient,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12)),
          ),
          Expanded(
            flex: 7,
            child: Container(
                child: Text(
                  text1!,
                  style: TextStyle(
                      color: AppColors.greyWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
          ),
        ],
      ),
    );
  }
}

class Shader extends StatelessWidget {
  final Icon? icon;

  Shader({this.icon});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [
              Color(0xff8760EE),
              Color(0xffA984E5),
              Color(0xffCA88E8),
            ],
            tileMode: TileMode.repeated,
          ).createShader(bounds);
        },
        child: icon);
  }
}
