import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/WishListModel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:syncfusion_flutter_core/theme.dart';

import 'alertTextfield.dart';

int? frequencyIndex1;
int? TypeIndex1;

class MintAlertPage extends StatefulWidget {
  final Results? results;

  const MintAlertPage({Key? key, this.results}) : super(key: key);

  @override
  State<MintAlertPage> createState() => _MintAlertPageState();
}

class _MintAlertPageState extends State<MintAlertPage> {
  PostData? postData;
  TextEditingController valueController = TextEditingController();
  TextEditingController mintController1 = TextEditingController();
  TextEditingController mintController2 = TextEditingController();
  int value = 0;
  SfRangeValues _values = const SfRangeValues(45, 55);
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  bool? mintAlert = false;
  int j = 0;
  Widget? ranger;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  String? frequencyValue = 'Once';
  var frequencyItems = [
    'Once',
    'Once a day',
    'Always',
  ];

  String? priceTypeValue = 'Below';
  var items = [
    'Below',
    'Above',
    'Between',
  ];

  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    getData = Provider.of<GetData>(context, listen: false);

    if (widget.results!.productDetail!.isProductAlert == true) {
      for (int i = 0; i < 2; i++) {
        if (widget.results!.productDetail!.productAlertData![i].type == 1) {
          setState(() {
            mintAlert = true;
            j = i;
          });
        }
      }
    }

    if (widget.results!.productDetail!.isProductAlert == true) {
      if (widget.results!.productDetail!.productAlertData![j].type == 1) {
        valueController.text = widget.results!.productDetail!.productAlertData![j].value.toString();

        //if mint ranger value exists
        _values = SfRangeValues(widget.results!.productDetail!.productAlertData![j].mintLow,
            widget.results!.productDetail!.productAlertData![j].mintUpper);

        if (valueController.text == "0.0") {
          valueController.text = value.toString();
        }
      }
    }

    if (mintAlert == true) {
      frequencyValue = widget.results!.productDetail!.productAlertData![j].frequencyValue;

      priceTypeValue = widget.results!.productDetail!.productAlertData![j].typeValue;
    }

    frequencyValue == 'Once'
        ? frequencyIndex1 = 0
        : frequencyValue == 'Once a day'
            ? frequencyIndex1 = 1
            : frequencyIndex1 = 2;

    priceTypeValue == 'Below'
        ? TypeIndex1 = 4
        : priceTypeValue == 'Above'
            ? TypeIndex1 = 5
            : TypeIndex1 = 6;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        children: [
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
              items: frequencyItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  frequencyValue = value;

                  frequencyValue == 'Once'
                      ? frequencyIndex1 = 0
                      : frequencyValue == 'Once a day'
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
            height: 8.h,
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
              value: priceTypeValue,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  priceTypeValue = value;

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
          SizedBox(
            height: 8.h,
          ),
          mintAlert == true
              ? (widget.results!.productDetail!.productAlertData![j].priceType == 6 && TypeIndex1 == 6
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select range",
                          style: TextStyle(fontSize: 18.0.sp, color: AppColors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.06945,
                        ),
                        SfRangeSliderTheme(
                          data: SfRangeSliderThemeData(
                            tooltipBackgroundColor: Colors.transparent,
                            thumbStrokeWidth: 2,
                            thumbStrokeColor: AppColors.white,
                            overlayRadius: 10,
                            labelOffset: Offset(0, -40),
                          ),
                          child: SfRangeSlider(
                            min: 0,
                            max: 100,
                            showTicks: true,
                            showLabels: true,
                            inactiveColor: Colors.white,
                            enableTooltip: true,
                            shouldAlwaysShowTooltip: true,
                            stepSize: 1,
                            values: _values,
                            onChanged: (SfRangeValues newValues) {
                              setState(() {
                                _values = newValues;
                                print(_values.start.toString());
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : widget.results!.productDetail!.productAlertData![j].priceType == 6 && TypeIndex1 != 6
                      ? AlertTextField(
                          height: Get.height * .03,
                          controller: valueController,
                        )
                      : widget.results!.productDetail!.productAlertData![j].priceType != 6 && TypeIndex1 != 6
                          ? AlertTextField(
                              height: Get.height * .03,
                              controller: valueController,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select range",
                                  style: TextStyle(fontSize: 18.0.sp, color: AppColors.white),
                                ),
                                SizedBox(
                                  height: Get.height * 0.06945,
                                ),
                                SfRangeSliderTheme(
                                  data: SfRangeSliderThemeData(
                                    tooltipBackgroundColor: Colors.transparent,
                                    thumbStrokeWidth: 2,
                                    thumbStrokeColor: AppColors.white,
                                    overlayRadius: 10,
                                    labelOffset: Offset(0, -40),
                                  ),
                                  child: SfRangeSlider(
                                    min: 0,
                                    max: 100,
                                    showTicks: true,
                                    showLabels: true,
                                    inactiveColor: Colors.white,
                                    enableTooltip: true,
                                    shouldAlwaysShowTooltip: true,
                                    stepSize: 2,
                                    values: _values,
                                    onChanged: (SfRangeValues newValues) {
                                      setState(() {
                                        _values = newValues;
                                        print(_values.start.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))
              : TypeIndex1 == 6
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select range",
                          style: TextStyle(fontSize: 18.0.sp, color: AppColors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.06945,
                        ),
                        SfRangeSliderTheme(
                          data: SfRangeSliderThemeData(
                            tooltipBackgroundColor: Colors.transparent,
                            thumbStrokeWidth: 2,
                            thumbStrokeColor: AppColors.white,
                            overlayRadius: 10,
                            labelOffset: Offset(0, -40),
                          ),
                          child: SfRangeSlider(
                            min: 0,
                            max: 100,
                            showTicks: true,
                            showLabels: true,
                            inactiveColor: Colors.white,
                            enableTooltip: true,
                            shouldAlwaysShowTooltip: true,
                            stepSize: 2,
                            values: _values,
                            onChanged: (SfRangeValues newValues) {
                              setState(() {
                                _values = newValues;
                                print(_values.start.toString());
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : AlertTextField(
                      height: Get.height * .03,
                      controller: valueController,
                    ),
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
                    postData!.deleteAlert(context, widget.results!.alertData!.id, requestHeadersWithToken);
                  },
                  child: Text(
                    widget.results!.productDetail!.productAlertData != null && mintAlert == true ? 'Delete' : "",
                    style: TextStyle(fontSize: 16.0.sp, color: AppColors.grey),
                  ),
                ),
                AppSpaces.spaces_width_10,
                InkWell(
                  onTap: () {
                    postData = Provider.of<PostData>(context, listen: false);
                    var body = {
                      "product": widget.results!.productDetail!.id,
                      "type": 1,
                      "price_type": TypeIndex1,
                      "value": valueController.text != "" ? double.parse(valueController.text) : 0.0,
                      "frequency": frequencyIndex1,
                      "mint_low": _values.start.round().toString(),
                      "mint_upper": _values.end.round().toString(),
                    };

                    postData!.createAlert(context, body);
                  },
                  child: Text(
                    widget.results!.productDetail!.productAlertData != null && mintAlert == true ? 'Update' : "Save",
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
      ));
}
