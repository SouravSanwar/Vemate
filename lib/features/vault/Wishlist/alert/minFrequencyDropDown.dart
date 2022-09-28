import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/WishListModel.dart';

int? frequencyIndex1;

class MintFrequencyDropDown extends StatefulWidget {
  final Results? results;

  const MintFrequencyDropDown({Key? key, this.results}) : super(key: key);

  @override
  State<MintFrequencyDropDown> createState() => _MintFrequencyDropDownState();
}

class _MintFrequencyDropDownState extends State<MintFrequencyDropDown> {
  String? value = 'Once';
  var items = [
    'Once',
    'Once a day',
    'Always',
  ];

  GetData? getData;
  bool? mintAlert = false;
  int i=0;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

/*    for(i=0; i <2; i++) {
      (
          widget.results!.productDetail!.productAlertData![i].type == 1
              ? mintAlert = true :mintAlert =false
      );
    }*/

    if (widget.results!.productDetail!.isProductAlert ==true) {

      mintAlert==true
          ? value = widget.results!.productDetail!.productAlertData![i].frequencyValue
          : value = 'Once';
    }

    value == 'Once'
        ? frequencyIndex1 = 0
        : value == 'Once a day'
        ? frequencyIndex1 = 1
        : frequencyIndex1 = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Frequency",
          style: TextStyle(
              fontSize: 18.0.sp, color: AppColors.textColor),
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
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
                    ? frequencyIndex1 = 0
                    : value == 'Once a day'
                    ? frequencyIndex1 = 1
                    : frequencyIndex1 = 2;

              }); //get value when changed
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),

            iconEnabledColor: Colors.grey,
            //Icon color
            style: TextStyle(
              //te
                color: AppColors.grey,
                fontFamily: 'Inter',//Font color
                fontSize: 20.sp //font size on dropdown button
            ),
            dropdownColor: AppColors.backgroundColor,
            underline: Container(),
            //dropdown background color
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter',fontSize: 15.sp),
      ));
}
