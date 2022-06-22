import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/WishListModel.dart';

int? frequencyIndex;

class AlertFrequencyDropDown extends StatefulWidget {
  final Results? results;

  const AlertFrequencyDropDown({Key? key, this.results}) : super(key: key);

  @override
  State<AlertFrequencyDropDown> createState() => _AlertFrequencyDropDownState();
}

class _AlertFrequencyDropDownState extends State<AlertFrequencyDropDown> {
  String? value;
  var items = [
    'Once',
    'Once a day',
    'Always',
  ];

  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);


    widget.results!.isAlert == true
        ? value = widget.results!.alertData!.frequencyValue
        : value = 'Once';
    value == 'Once'
        ? frequencyIndex = 0
        : value == 'Once a day'
        ? frequencyIndex = 1
        : frequencyIndex = 2;
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
            width: 1.w), // set border width
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

            value == 'Once'
                ? frequencyIndex = 0
                : value == 'Once a day'
                    ? frequencyIndex = 1
                    : frequencyIndex = 2;

            print(frequencyIndex);
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
            fontSize: 20.sp //font size on dropdown button
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
        style: TextStyle(fontSize: 15.sp),
      ));
}
