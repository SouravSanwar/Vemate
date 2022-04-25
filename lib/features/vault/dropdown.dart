import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class DropDown extends StatefulWidget {
  final Color color;


  DropDown(this.color);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? value="24H";
  final items=['24H','7D','30D','60D','1Y'];

  @override
  Widget build(BuildContext context) {
    return Positioned(

      top: Get.height * .235,
      left: Get.width * .62,
      right: 0.0,
      child: DropdownButton<String>(
          value: value,
          items: items.map(buildMenuItem).toList(),
          onChanged: (value){
            setState(() {
              this.value=value;
            });//get value when changed

          },
          icon: const Icon(Icons.arrow_drop_down,size: 10,),

          iconEnabledColor: Colors.white, //Icon color
          style: const TextStyle(  //te
              color: Colors.white, //Font color
              fontSize: 20 //font size on dropdown button
          ),
          dropdownColor: widget.color,
          underline: Container(),//dropdown background color
          borderRadius: BorderRadius.all(Radius.circular(10),),
        ),
      );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
          value: item,
          child: Text(item,style: TextStyle(fontSize: 15),)
      );
}
