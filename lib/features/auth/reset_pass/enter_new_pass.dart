import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import '../presentation/sign_in/_controller/sign_in_controller.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({Key? key}) : super(key: key);

  @override
  _EnterNewPasswordState createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
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
              BackPreviousScreen(),
              SizedBox(
                height: Get.height * .07,
              ),
              Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "Enter New Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                  AppSpaces.spaces_height_25,

                  PasswordInputField(
                      labelText: "Password",
                      height: Get.height*.04,
                      textType: TextInputType.text,
                      controller:
                      SigninController.to.passwordTextFiledController),

                  SizedBox(height: Get.height*.022,),

                  PasswordInputField(
                      labelText: "Confirm Password",
                      height: Get.height*.04,
                      textType: TextInputType.text,
                      controller:
                      SigninController.to.passwordTextFiledController),
                   SizedBox(
                    height: Get.height*.07,
                  ),

                  CustomButtons(
                    width: Get.width*.9,
                    height: Get.height * .065,
                    onTap: () {
                      Get.toNamed(AppRoutes.CONTROLLER_PAGE);

                    },
                    text: AppLanguageString.UPDATE_Pass.tr.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(color: Colors.white),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
