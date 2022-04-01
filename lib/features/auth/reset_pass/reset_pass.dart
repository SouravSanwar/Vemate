import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/features/auth/reset_pass/forgot_pass.dart';
import 'package:provider/provider.dart';

import '../../../app_routes/app_routes.dart';
import '../../../core/language/language_string.dart';
import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/password_input_field.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';
import '../presentation/sign_in/_controller/sign_in_controller.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = TextEditingController();

  PostData? postData;

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);

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
              AppSpaces.spaces_height_15,
              SizedBox(
                height: Get.height * .2,
                width: Get.width * 1,
                child: Image.asset(
                  'assets/media/image/vemate.png',
                  fit: BoxFit.cover,
                ),
              ),
              //AppSpaces.spaces_height_15,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: Get.width * .9,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "RESET PASSWORD",
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
                          Radius.circular(20.0)), // set rounded corner radius
                    ),
                    child: TextButton(
                      onPressed: () {
                        var body = {"email": emailController.text};
                        postData!.resendCode(context, body).whenComplete(
                              () => Get.to(
                                () => const ForgotPassword(),
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
                      "By clicking RESET, you will receive an e-mail to reset password",
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
