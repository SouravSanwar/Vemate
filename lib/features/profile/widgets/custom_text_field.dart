import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController ? controller;
  final IconData? data;
  final IconData? data1;
  final String? hintText;
  bool? input=true;
  bool? isObsecre= true;
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(

        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(

          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.green,
          ),
          suffixIcon: IconButton(
            color: Colors.green,
            onPressed: () {
              isObsecre=!isObsecre!;
            }, icon: Icon(
            data1

          ),
          ),

          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,

        ),
      ),
    );
  }
}

class divider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Divider(
            height: 8,
            color: Colors.grey,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
