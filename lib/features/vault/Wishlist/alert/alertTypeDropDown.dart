
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

int? TypeIndex;
class AlertTypeDropDown extends StatefulWidget {

  @override
  State<AlertTypeDropDown> createState() => _AlertTypeDropDownState();
}

class _AlertTypeDropDownState extends State<AlertTypeDropDown> {
  String? value = 'Price rises above';
  var items = [
    'Price rises above',
    'Price drops under',
    'Price rises',
    'Price drops',
  ];



  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      width: Get.width,

      decoration: BoxDecoration(
        color: AppColors.textBoxBgColor,
        border: Border.all(
            color: AppColors.textColor, // set border color
            width: 1), // set border width
        borderRadius: const BorderRadius.all(
            Radius.circular(15.0)), // set rounded corner radius
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        items: items.map(buildMenuItem).toList(),
        onChanged: (value) {
          setState(() {
            this.value = value;

            value == 'Price rises above'
                ? TypeIndex = 0
                : value == 'Price drops under'
                ? TypeIndex = 1
                : value == 'Price rises'
                ? TypeIndex = 2
                 :TypeIndex = 3;
            print(TypeIndex);
          }); //get value when changed
        },
        icon: const Icon(
          Icons.keyboard_arrow_down,

        ),

        iconEnabledColor: Colors.grey,
        //Icon color
        style: TextStyle(
          //te
            color: AppColors.textColor, //Font color
            fontSize: 20 //font size on dropdown button
        ),
        dropdownColor: AppColors.backgroundColor,
        underline: Container(),
        //dropdown background color
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 15),
      ));
}
