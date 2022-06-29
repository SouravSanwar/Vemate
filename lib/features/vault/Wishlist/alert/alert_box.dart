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
              style: TextStyle(fontFamily: 'Inter',fontSize: 22.0, color: AppColors.textColor),
            ),
            /*AnimatedContainer(
            padding: const EdgeInsets.only(left: 2, right: 2),
            duration: const Duration(milliseconds: 100),
            height: 30.0.h,
            width: 60.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: toggleValue == true ? Colors.purple : Colors.grey,
            ),
            child: Stack(

              children: <Widget>[
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    top: 3.0,
                    left: toggleValue == true ? 30.0 : 0.0,
                    right: toggleValue == true ? 0.0 : 30.0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          toggleValue = !toggleValue!;
                        });
                      },
                      child:  Container(
                        alignment: toggleValue == true ?Alignment.centerLeft :Alignment.centerLeft ,
                        height: 25.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),

                      ),

                    ))
              ],
            ),
          )*/
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
                      /*Text(
                            "Mint",
                            style: TextStyle(fontSize: 20.0.sp, color: AppColors.textColor),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                         Row(
                            children: [
                              Expanded(
                                child: AlertTextField(
                                  height: Get.height*.02,
                                  controller: mintController1,
                                ),
                              ),
                               SizedBox(width: 10.w,),
                              Text("-",style: TextStyle(color: AppColors.textColor,fontSize: 25.sp),),
                              const SizedBox(width: 10,),
                              Expanded(
                                child:AlertTextField(
                                height: Get.height*.02,
                                controller: mintController2,
                              ),
                              ),


                            ],
                          ),*/
                      SizedBox(
                        height: 15.h,
                      ),
                      /*Text(
                            "Price",
                            style: TextStyle(fontSize: 20.0.sp, color: AppColors.textColor),
                            textAlign: TextAlign.left,
                          ),*/
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Value",
                        style: TextStyle(
                            fontSize: 20.0.sp, color: AppColors.textColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AlertTextField(
                        height: Get.height * .03,
                        controller: valueController,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 20.0.sp, color: AppColors.textColor),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      AlertTypeDropDown(
                        results: widget.results,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Frequency",
                        style: TextStyle(
                            fontSize: 20.0.sp, color: AppColors.textColor),
                      ),
                      SizedBox(
                        height: 10.h,
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
                                Get.back();
                              },
                              child: Text(
                                widget.results!.isAlert == true ? 'Delete' : "",
                                style: TextStyle(
                                    fontSize: 16.0.sp, color: Colors.red),
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
                                  "value": valueController.text != "" ?double.parse(valueController.text):0.0,
                                  "frequency": frequencyIndex,
                                };

                                postData!.createAlert(context, body);
                                Get.back();
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
