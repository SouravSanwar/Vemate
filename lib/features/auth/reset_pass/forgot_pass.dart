import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();

  PostData? postData;

  @override
  void initState() {
    // TODO: implement initState
    emailController.text = prefs!.getString('email')!;

    postData = Provider.of<PostData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
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
                  mode == 0
                      ? 'assets/media/image/vemate1.png'
                      : 'assets/media/image/vemate.png',
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
                      child: Text(
                        "Enter New Password",
                        style: TextStyle(
                            //fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      )),
                  AppSpaces.spaces_height_25,
                  TextInputField(
                    labelText: "Email",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: Get.height * .022,
                  ),
                  TextInputField(
                    labelText: "Code",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: codeController,
                  ),
                  SizedBox(
                    height: Get.height * .022,
                  ),
                  PasswordInputField(
                      labelText: "New Password",
                      height: Get.height * .04,
                      textType: TextInputType.text,
                      controller: passController),
                  SizedBox(
                    height: Get.height * .07,
                  ),
                  CustomButtons(
                    width: Get.width * .9,
                    height: Get.height * .065,
                    onTap: () {
                      var body = {
                        "email": emailController.text,
                        "code": codeController.text,
                        "password": passController.text
                      };

                      postData!.forgotPassword(context, body);
                    },
                    text: AppLanguageString.UPDATE_Pass.tr.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
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
