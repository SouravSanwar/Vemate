import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  double _height = 0;
  double _width = 0;
  double _pixelRatio = 0;
  bool _large = false;
  bool _medium = false;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  PostData? postData;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    postData = Provider.of<PostData>(context, listen: false);
   /* var body = {
      "email": prefs!.getString('email').toString(),
      "reason": "verify",
    };
    postData!.resendCode(context, body);*/

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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return WillPopScope(
      onWillPop: () async {
        /*Navigator.of(context).pushNamedAndRemoveUntil(
            NAVIGATION_HOME, (Route<dynamic> route) => false);*/
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              BackPreviousScreen(),
              SizedBox(
                height: Get.height * .07,
              ),
              SizedBox(
                height: Get.height * .18,
                width: Get.width * .9,
                child: Image.asset(
                  'assets/media/image/vemate.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Email Verification',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: "${prefs!.getString('email')}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 15)),
                      ],
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpaces.spaces_height_20,
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
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
                      // onTap: () {
                      //   print("Pressed");
                      // },
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
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        var body = {
                          "email": "${prefs!.getString('email')}",
                          "reason": "verify",
                        };

                        postData!.resendCode(context, body);
                      },
                      child: Text(
                        "RESEND",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.purpleGradient, // set border width
                  borderRadius: const BorderRadius.all(
                      Radius.circular(25.0)), // set rounded corner radius
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      if (currentText.length != 6) {
                        errorController!.add(ErrorAnimationType.shake);
                        setState(() => hasError = true);
                      } else {
                        setState(
                          () {
                            hasError = false;

                            var body = {
                              "email": "${prefs!.getString('email')}",
                              "code": currentText
                            };

                            printInfo(info: body.toString());

                            postData!.verifyCode(context, body);
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),

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
    );
  }
}
