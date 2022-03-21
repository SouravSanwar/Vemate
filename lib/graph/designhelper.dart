import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return MaterialButton(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: widget.child,
      color: Color(0xff02d39a).withOpacity(0.7),
      highlightElevation: 5,
      minWidth: 20,
      splashColor: Color(0x1F1A1A1A),

      onPressed: () {
        widget.onPressed();
      },

    );
  }
}

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
            borderSide: BorderSide(
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
            height: 1,
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ),
    );
  }

}
