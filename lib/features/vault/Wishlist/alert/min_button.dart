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
  SfRangeValues _values = SfRangeValues(20.0, 80.0);
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    if (widget.results!.isAlert == true) {
      if (widget.results!.alertData!.type == 0) {
        valueController.text = widget.results!.alertData!.value.toString();
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

      children: [
        TypeIndex1 == 6 ? SizedBox(height: 50,) : Container(),
        TypeIndex1 == 6
            ? SfRangeSliderTheme(
                data: SfRangeSliderThemeData(

                  tooltipBackgroundColor: Colors.transparent,
                  thumbStrokeWidth: 2,
                  thumbStrokeColor: AppColors.white,
                  overlayRadius: 10,
                 labelOffset: Offset(0,-40) ,

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
              )
            : AlertTextField(
                height: Get.height * .03,
                controller: valueController,
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
                  postData!.deleteAlert(context, widget.results!.alertData!.id,
                      requestHeadersWithToken);
                },
                child: Text(
                  widget.results!.isAlert == true &&
                          widget.results!.alertData!.type == 1
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
                    "mint_low": _currentRangeValues.start.round().toString(),
                    "mint_upper": _currentRangeValues.end.round().toString(),
                  };

                  postData!.createAlert(context, body);
                },
                child: Text(
                  widget.results!.isAlert == true &&
                          widget.results!.alertData!.type == 1
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
