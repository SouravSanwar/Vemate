import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/WishListModel.dart';

int? TypeIndex;

class AlertTypeDropDown extends StatefulWidget {
  final Results? results;

  const AlertTypeDropDown({Key? key, this.results}) : super(key: key);

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


    if (widget.results!.isAlert == true) {
      print("66666666666--"+widget.results!.alertData!.type.toString());
      widget.results!.alertData!.type == 0
          ? value = widget.results!.alertData!.typeValue
          : value = 'Price rises above';
    }
    value == 'Price rises above'
        ? TypeIndex = 0
        : value == 'Price drops under'
        ? TypeIndex = 1
        : value == 'Price rises'
        ? TypeIndex = 2
        : TypeIndex = 3;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type",
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

                value == 'Price rises above'
                    ? TypeIndex = 0
                    : value == 'Price drops under'
                    ? TypeIndex = 1
                    : value == 'Price rises'
                    ? TypeIndex = 2
                    : TypeIndex = 3;
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
                color: AppColors.grey, //Font color
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