import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff272E49),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppSpaces.spaces_height_15,
              Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "RESET PASSWORD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                  AppSpaces.spaces_height_25,
                 /* Container(
                      width: Get.width * .9,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "E-mail",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 12),
                      )),*/
                  TextInputField(
                    labelText: "Enter e-mail",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: SigninController.to.emailTextFiledController,
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleGradient, // set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(20.0)), // set rounded corner radius
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.CONTROLLER_PAGE);
                        /*SigninController.to.signIn(
                          email: SigninController
                              .to.emailTextFiledController.text
                              .toString(),
                          password: SigninController
                              .to.passwordTextFiledController.text
                              .toString(),
                        );*/
                      },
                      child: Text(
                        AppLanguageString.RESET_PASS.tr.toUpperCase(),
                        style:
                        Get.textTheme.button!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 70,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
