import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertFrequencyDropdown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTypeDropDown.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../core/models/WishListModel.dart';
import '../../../../core/utilities/app_colors/dark_white_mode.dart';

class AlertButton extends StatefulWidget {
  final Results? results;

  const AlertButton({Key? key, this.results}) : super(key: key);

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton> {
  PostData? postData;
  TextEditingController valueController = TextEditingController();
  TextEditingController mintController1 = TextEditingController();
  TextEditingController mintController2 = TextEditingController();
  int value = 0;
  SfRangeValues _values = const SfRangeValues(45, 55);
  bool? toggleValue = false;
  bool? hasDropDownValue = false;
  bool? priceAlert = false;
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
      
        if(widget.results!.productDetail!.productAlertData![i].type == 0)
        {
          setState(() {
            priceAlert = true;
            j = i ;
          });
        }
      }
    }


    if (widget.results!.productDetail!.isProductAlert == true) {
      if (widget.results!.productDetail!.productAlertData![j].type == 0) {
        valueController.text = widget
            .results!.productDetail!.productAlertData![j].value
            .toString();

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
        AlertTextField(
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
                  postData!.deleteAlert(context, widget.results!.alertData!.id, requestHeadersWithToken);
                },
                child: Text(
                  widget.results!.productDetail!.productAlertData != null &&
                      priceAlert == true ? 'Delete' : "",
                  style: TextStyle(fontSize: 16.0.sp, color: AppColors.grey),
                ),
              ),
              AppSpaces.spaces_width_10,
              InkWell(
                onTap: () {
                  postData = Provider.of<PostData>(context, listen: false);
                  var body = {
                    "product": widget.results!.productDetail!.id,
                    "type": 0,
                    "price_type": TypeIndex,
                    "value": valueController.text != "" ? double.parse(valueController.text) : 0.0,
                    "frequency": frequencyIndex,
                  };

                  postData!.createAlert(context, body);
                },
                child: Text(
                  widget.results!.productDetail!.productAlertData != null &&
                      priceAlert == true ? 'Update' : "Save",
                  style: TextStyle(fontSize: 16.0.sp, color: Colors.purpleAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
