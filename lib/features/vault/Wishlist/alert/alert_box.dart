import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertFrequencyDropdown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTypeDropDown.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/WishListModel.dart';

class ShowAlertBox extends StatefulWidget {
  final Results? results;

  const ShowAlertBox({Key? key, this.results}) : super(key: key);

  @override
  _ShowAlertBoxState createState() => _ShowAlertBoxState();
}

class _ShowAlertBoxState extends State<ShowAlertBox> {
  TextEditingController valueController = TextEditingController();
  TextEditingController mintController1 = TextEditingController();
  TextEditingController mintController2 = TextEditingController();
  int value = 0;

  bool? toggleValue = false;
  bool? hasDropDownValue = false;

  PostData? postData;

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    if (widget.results!.isAlert == true) {
      valueController.text = widget.results!.alertData!.value.toString();
      if (valueController.text == "0.0") {
        valueController.text = value.toString();
      }
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.only(
          top: 10.0,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price Alert",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  color: AppColors.textColor),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    radius: 14.0,
                    child: Icon(Icons.close_sharp, color: Colors.grey),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.greyWhite,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        content: /*toggleValue == true
          ?  */
            SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
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
                      SizedBox(
                        height: 14.sp,
                      ),
                      Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 18.0.sp, color: AppColors.textColor),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      AlertTypeDropDown(
                        results: widget.results,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        "Frequency",
                        style: TextStyle(
                            fontSize: 18.0.sp, color: AppColors.textColor),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AlertFrequencyDropDown(
                        results: widget.results,
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
                                postData = Provider.of<PostData>(context,
                                    listen: false);
                                /*var body = {
                                  "product": widget.results!.productDetail!.id,
                                  "type": 0,
                                  "price_type": TypeIndex,
                                  "value": double.parse(valueController.text),
                                  "frequency": frequencyIndex,
                                };*/

                                postData!.deleteAlert(
                                    context,
                                    widget.results!.alertData!.id,
                                    requestHeadersWithToken);
                              },
                              child: Text(
                                widget.results!.isAlert == true ? 'Delete' : "",
                                style: TextStyle(
                                    fontSize: 16.0.sp, color: AppColors.grey),
                              ),
                            ),
                            AppSpaces.spaces_width_10,
                            InkWell(
                              onTap: () {

                                postData = Provider.of<PostData>(context,
                                    listen: false);
                                var body = {
                                  "product": widget.results!.productDetail!.id,
                                  "type": 0,
                                  "price_type": TypeIndex,
                                  "value": valueController.text != ""
                                      ? double.parse(valueController.text)
                                      : 0.0,
                                  "frequency": frequencyIndex,
                                };

                                postData!.createAlert(context, body);
                              },
                              child: Text(
                                widget.results!.isAlert == true
                                    ? 'Update'
                                    : "Save",
                                style: TextStyle(
                                    fontSize: 16.0.sp,
                                    color: Colors.purpleAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.sp,
                      ),
                    ],
                  ),
                ))
        /*: Container(
        height: Get.height * .01,
      ),*/
        );
  }
}
