import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/WishListModel.dart';

int? TypeIndex1;

class MintTypeDropDown extends StatefulWidget {
  final Results? results;

  const MintTypeDropDown({Key? key, this.results}) : super(key: key);

  @override
  State<MintTypeDropDown> createState() => _MintTypeDropDownState();
}

class _MintTypeDropDownState extends State<MintTypeDropDown> {
  String? value = 'Below';
  var items = [
    'Below',
    'Above',
    'Between',
  ];

  GetData? getData;
  bool? mintAlert = false;
  int i = 0,j=0;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);
    if (widget.results!.productDetail!.isProductAlert == true) {
      for (i = 0; i < 2; i++) {
      
        if(widget.results!.productDetail!.productAlertData![i].type == 1)
        {
          setState(() {
            mintAlert = true;
            j = i ;
          });
        }
      }
    }

    if (mintAlert == true) {
      value =
          widget.results!.productDetail!.productAlertData![j].typeValue;
      print("jjjjjjj--"+value.toString());
    }

    value == 'Below'
        ? TypeIndex1 = 4
        : value == 'Above'
            ? TypeIndex1 = 5
            : TypeIndex1 = 6;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type",
          style: TextStyle(fontSize: 18.0.sp, color: AppColors.textColor),
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

                value == 'Below'
                    ? TypeIndex1 = 4
                    : value == 'Above'
                        ? TypeIndex1 = 5
                        : TypeIndex1 = 6;
                print(TypeIndex1);
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
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));
}
