import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final bool registration;

  const OtpPage({Key? key, required this.registration}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  PostData? postData;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    postData = Provider.of<PostData>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return WillPopScope(
      onWillPop: () async {
        /*Navigator.of(context).pushNamedAndRemoveUntil(
            NAVIGATION_HOME, (Route<dynamic> route) => false);*/
        return true;
      },
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.onBoardGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                const BackPreviousScreen(),
                SizedBox(
                  height: Get.height * .02,
                ),
                SizedBox(
                  height: Get.height * .18,
                  width: Get.width * .9,
                  child: Image.asset(
                    mode == 0 ? 'assets/media/image/vemate1.png' : 'assets/media/image/vemate2.png',
                    fit: mode == 0 ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Email Verification',
                    style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold, fontSize: 22.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: "${prefs!.getString('email')}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 15.sp)),
                        ],
                        style: const TextStyle(color: Colors.white, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppSpaces.spaces_height_20,
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          selectedFillColor: AppColors.primaryColor,
                          selectedColor: AppColors.lightBackgroundColor,
                          inactiveFillColor: AppColors.lightBackgroundColor,
                          inactiveColor: AppColors.primaryColor,
                          activeColor: AppColors.borderColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: AppColors.primaryColor,
                        ),
                        cursorColor: Colors.white,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Please fill up all the cells properly" : "",
                    style: TextStyle(
                        fontFamily: 'Inter', color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 15.sp),
                    ),
                    TextButton(
                        onPressed: () {
                          var body = {
                            "email": "${prefs!.getString('email')}",
                            "user_checking": false,
                            "reason": "verify",
                          };

                          postData!.resendCode(context, body);
                        },
                        child: Text(
                          "RESEND",
                          style: TextStyle(fontFamily: 'Inter', color: AppColors.primaryColor, fontSize: 16.sp),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButtons(
                    width: Get.width * .9,
                    height: Get.height * .065,
                    onTap: () {
                      formKey.currentState!.validate();
                      if (currentText.length != 6) {
                        errorController!.add(ErrorAnimationType.shake);
                        setState(() => hasError = true);
                      } else {
                        setState(
                          () {
                            hasError = false;

                            var bodyForUpdate = {
                              "email": "${prefs!.getString('email')}",
                              "code": currentText,
                            };

                            var bodyForRegistration = {
                              "email": "${prefs!.getString('email')}",
                              "code": currentText,
                              "user": {
                                "nickname": "${prefs!.getString('nickname')}",
                                "email": "${prefs!.getString('email')}",
                                "gender": "0",
                                "birth_year": "1852",
                                "fcm_device_id": "3",
                                "password": "${prefs!.getString('password')}",
                              }
                            };

                            postData!.verifyCode(
                              context,
                              widget.registration == true ? bodyForRegistration : bodyForUpdate,
                            );
                          },
                        );
                      }
                    },
                    text: "VERIFY".toUpperCase(),
                    style: Get.textTheme.button!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                )

                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                        child: TextButton(
                      child: Text("Clear"),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    )),
                    Flexible(
                        child: TextButton(
                      child: Text("Set Text"),
                      onPressed: () {
                        setState(() {
                          textEditingController.text = "123456";
                        });
                      },
                    )),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
