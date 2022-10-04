import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/WishListModel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:syncfusion_flutter_core/theme.dart';


int? frequencyIndex;
int? TypeIndex;

class PriceAlertPage extends StatefulWidget {
  var results;
  String? origin;
   PriceAlertPage({Key? key, this.results,this.origin}) : super(key: key);

  @override
  State<PriceAlertPage> createState() => _PriceAlertPageState();
}

class _PriceAlertPageState extends State<PriceAlertPage> {
  PostData? postData;
  GetData? getData;
  TextEditingController valueController = TextEditingController();
  TextEditingController mintController1 = TextEditingController();
  TextEditingController mintController2 = TextEditingController();
  int value = 0;
  SfRangeValues _values = const SfRangeValues(45, 55);
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  bool? priceAlert = false;
  int j = 0;
  Widget? ranger;
  

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };
  String? frequencyValue = 'Once';
  var frequencyItem = [
    'Once',
    'Once a day',
    'Always',
  ];

  String? priceValue = 'Price rises above';
  var priceItems = [
    'Price rises above',
    'Price drops under',
    'Price rises',
    'Price drops',
  ];

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

    if (widget.results!.isProductAlert == true) {
      for (int i = 0; i < widget.results!.productAlertData!.length; i++) {
        if (widget.results!.productAlertData![i].type == 0) {
          setState(() {
            priceAlert = true;
            j = i;
          });
        }
      }
    }
    if (priceAlert == true) {
      frequencyValue = widget.results!.productAlertData![j].frequencyValue;
      priceValue = widget.results!.productAlertData![j].typeValue;
    }

    if (widget.results!.isProductAlert == true) {
      if (widget.results!.productAlertData![j].type == 0) {
        valueController.text = widget.results!.productAlertData![j].value.toString();

        if (valueController.text == "0.0") {
          valueController.text = value.toString();
        }
      }
    }

    frequencyValue == 'Once'
        ? frequencyIndex = 0
        : frequencyValue == 'Once a day'
            ? frequencyIndex = 1
            : frequencyIndex = 2;

    priceValue == 'Price rises above'
        ? TypeIndex = 0
        : priceValue == 'Price drops under'
            ? TypeIndex = 1
            : priceValue == 'Price rises'
                ? TypeIndex = 2
                : TypeIndex = 3;
    super.initState();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Frequency",
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
              borderRadius: const BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: frequencyValue,
              items: frequencyItem.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  frequencyValue = value;

                  value == 'Once'
                      ? frequencyIndex = 0
                      : value == 'Once a day'
                          ? frequencyIndex = 1
                          : frequencyIndex = 2;
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
                  fontFamily: 'Inter', //Font color
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
          SizedBox(
            height: 14.h,
          ),
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
              borderRadius: const BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: priceValue,
              items: priceItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  priceValue = value;

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
          SizedBox(
            height: 14.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Value",
                style: TextStyle(
                    fontSize: 18.0.sp, color: AppColors.textColor),
              ),
              SizedBox(
                height: 8.h,
              ),
              AlertTextField(
                height: Get.height * .03,
                controller: valueController,
              ),
            ],
          ),
          /*SizedBox( height: 14.sp,),*/

          SizedBox(
            height: 25.h,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    postData = Provider.of<PostData>(context, listen: false);
                    postData!.deleteAlert(
                        context, widget.results!.productAlertData![j].id, requestHeadersWithToken,widget.origin,widget.results!.id);
                  },
                  child: Text(
                    widget.results!.productAlertData != null && priceAlert == true ? 'Delete' : "",
                    style: TextStyle(fontSize: 16.0.sp, color: AppColors.grey),
                  ),
                ),
                AppSpaces.spaces_width_10,
                InkWell(
                  onTap: () {
                    postData = Provider.of<PostData>(context, listen: false);
                    var body = {
                      "product": widget.results!.id,
                      "type": 0,
                      "price_type": TypeIndex,
                      "value": valueController.text != "" ? double.parse(valueController.text) : 0.0,
                      "frequency": frequencyIndex,
                    };

                    postData!.createAlert(context, body,widget.origin,widget.results!.id);
                  },
                  child: Text(
                    widget.results!.productAlertData != null && priceAlert == true ? 'Update' : "Save",
                    style: TextStyle(fontSize: 16.0.sp, color: Colors.purpleAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
