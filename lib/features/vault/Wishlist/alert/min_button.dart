import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/minFrequencyDropDown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/mintTypeDropdown.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import '../../../../core/models/WishListModel.dart';
import '../../../../core/utilities/app_colors/dark_white_mode.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MintButton extends StatefulWidget {
  final Results? results;

  const MintButton({Key? key, this.results}) : super(key: key);

  @override
  State<MintButton> createState() => _MintButtonState();
}

class _MintButtonState extends State<MintButton> {
  PostData? postData;
  TextEditingController valueController = TextEditingController();
  TextEditingController mintController1 = TextEditingController();
  TextEditingController mintController2 = TextEditingController();
  int value = 0;
  SfRangeValues _values = const SfRangeValues(45, 55);
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  bool? mintAlert = false;
  int i = 0, j = 0;
  Widget? ranger;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    if (widget.results!.productDetail!.isProductAlert == true) {
      for (i = 0; i < 2; i++) {
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
        valueController.text = widget
            .results!.productDetail!.productAlertData![j].value
            .toString();

        //if mint ranger value exists
        _values = SfRangeValues(
            widget.results!.productDetail!.productAlertData![j].mintLow,
            widget.results!.productDetail!.productAlertData![j].mintUpper);

        if (valueController.text == "0.0") {
          valueController.text = value.toString();
        }
      }
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mintAlert == true
            ? (widget.results!.productDetail!.productAlertData![j].priceType ==
                        6 &&
                    TypeIndex1 == 6
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select range",
                        style: TextStyle(
                            fontSize: 18.0.sp, color: AppColors.white),
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
                : widget.results!.productDetail!.productAlertData![j]
                                .priceType ==
                            6 &&
                        TypeIndex1 != 6
                    ? AlertTextField(
                        height: Get.height * .03,
                        controller: valueController,
                      )
                    : widget.results!.productDetail!.productAlertData![j]
                                    .priceType !=
                                6 &&
                            TypeIndex1 != 6
                        ? AlertTextField(
                            height: Get.height * .03,
                            controller: valueController,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select range",
                                style: TextStyle(
                                    fontSize: 18.0.sp, color: AppColors.white),
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
                        style: TextStyle(
                            fontSize: 18.0.sp, color: AppColors.white),
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
                  postData!.deleteAlert(context, widget.results!.alertData!.id,
                      requestHeadersWithToken);
                },
                child: Text(
                  widget.results!.productDetail!.productAlertData != null &&
                          mintAlert == true
                      ? 'Delete'
                      : "",
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
                    "value": valueController.text != ""
                        ? double.parse(valueController.text)
                        : 0.0,
                    "frequency": frequencyIndex1,
                    "mint_low": _values.start.round().toString(),
                    "mint_upper": _values.end.round().toString(),
                  };

                  postData!.createAlert(context, body);
                },
                child: Text(
                  widget.results!.productDetail!.productAlertData != null &&
                          mintAlert == true
                      ? 'Update'
                      : "Save",
                  style:
                      TextStyle(fontSize: 16.0.sp, color: Colors.purpleAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
