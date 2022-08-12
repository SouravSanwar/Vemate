import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/features/auth/reset_pass/forgot_pass.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';
import '../../../core/utilities/common_widgets/text_input_field.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PostData? postData;

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.onBoardGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                        : 'assets/media/image/vemate2.png',
                    fit: mode == 0
                        ?BoxFit.cover
                        :BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: Get.width * .9,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "RESET PASSWORD",
                            style: TextStyle(
                                fontFamily: 'Inter', color: AppColors.textColor),
                          )),
                      AppSpaces.spaces_height_25,
                      TextInputField(
                        validator:  (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(
                              r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                              .hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                        },
                        labelText: "Enter email",
                        height: .09,
                        textType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButtons(
                        width: Get.width * .9,
                        height: Get.height * .065,
                        onTap: () {
                          var body = {
                            "email": emailController.text,
                            "reason": "forget_password",
                          };
                          prefs!.setString('email', emailController.text);
                          if (_formKey.currentState!.validate()) {
                            postData!.resendCode(context, body, isResetPass: true);
                          }

                        },
                        text: 'Send Code'.toUpperCase(),
                        style: Get.textTheme.button!.copyWith(
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "By clicking SEND CODE, you will receive an e-mail to reset password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.white.withOpacity(.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
