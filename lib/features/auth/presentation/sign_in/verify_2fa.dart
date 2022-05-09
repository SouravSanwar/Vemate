import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/sign_in_2fa.dart';
import 'package:ketemaa/features/auth/reset_pass/forgot_pass.dart';
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
      backgroundColor: const Color(0xff272E49),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: Get.width * .9,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "Verify Two Factor Authentication",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                  AppSpaces.spaces_height_25,
                  TextInputField(
                    labelText: "Enter e-mail",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleGradient, // set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(25.0)), // set rounded corner radius
                    ),
                    child: TextButton(
                      onPressed: () {
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
                      child: Text(
                        'Send Code'.toUpperCase(),
                        style:
                            Get.textTheme.button!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "By clicking RESET, you will receive an e-mail to verify two factor authentication",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
