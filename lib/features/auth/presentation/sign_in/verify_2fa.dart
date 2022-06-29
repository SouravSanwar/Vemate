import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/sign_in_2fa.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

class Verify2FA extends StatefulWidget {
  const Verify2FA({Key? key}) : super(key: key);

  @override
  _Verify2FAState createState() => _Verify2FAState();
}

class _Verify2FAState extends State<Verify2FA> {
  TextEditingController emailController = TextEditingController();

  PostData? postData;

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);

    printInfo(info: 'Email: ' + prefs!.getString('email').toString());
    var body = {
      "email": prefs!.getString('email').toString(),
      "reason": "verify",
    };
    postData!.resendCode(context, body).whenComplete(
          () => Get.to(
            () => const SignIn2FA(),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackPreviousScreen(),
              SizedBox(
                height: Get.height * .07,
              ),
              SizedBox(
                height: Get.height * .18,
                width: Get.width * .9,
                child: Image.asset(
                  mode==0? 'assets/media/image/vemate1.png':'assets/media/image/vemate.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: Get.width * .9,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "Verify Two Factor Authentication",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                  AppSpaces.spaces_height_25,
                  TextInputField(
                    labelText: "Enter e-mail",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  CustomButtons(
                    width: Get.width*.9,
                    height: Get.height * .065,
                    onTap: () {
                      var body = {
                        "email": emailController.text,
                        "reason": "verify",
                      };
                      postData!.resendCode(context, body).whenComplete(
                            () => Get.to(
                              () => const SignIn2FA(),
                        ),
                      );
                    },
                    text: 'Send Code'.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(color: Colors.white),
                  ),

                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "By clicking RESET, you will receive an e-mail to verify two factor authentication",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
