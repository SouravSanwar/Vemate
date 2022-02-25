import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/image_slider.dart';
import 'package:ketemaa/core/utilities/common_widgets/social_login_button.dart';

import '../../../../core/utilities/app_dimension/app_dimension.dart';
import '../../../../core/utilities/common_widgets/password_input_field.dart';
import '../../../../core/utilities/common_widgets/text_input_field.dart';
import '../sign_in/_controller/sign_in_controller.dart';

class AuthInitialPage extends StatefulWidget {
  const AuthInitialPage({Key? key}) : super(key: key);

  @override
  _AuthInitialPageState createState() => _AuthInitialPageState();
}

class _AuthInitialPageState extends State<AuthInitialPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppSpaces.spaces_height_15,
              Container(
                height: Get.width * .4,
                width: Get.width * .4,
                child: Image.asset(
                  'assets/media/image/low-price.png',
                  fit: BoxFit.cover,
                ),
              ),
              //AppSpaces.spaces_height_15,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppSpaces.spaces_height_15,
                  TextInputField(
                    labelText: AppLanguageString.USERNAME.tr,
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: SigninController.to.emailTextFiledController,
                  ),
                  //AppSpaces.spaces_height_5,
                  PasswordInputField(
                      labelText: AppLanguageString.PASSWORD.tr,
                      height: .09,
                      textType: TextInputType.text,
                      controller:
                          SigninController.to.passwordTextFiledController),
                  //AppSpaces.spaces_height_5,
                  Container(
                    margin: EdgeInsets.all(AppDimension.b1),
                    height: Get.height * .07,
                    width: Get.width * .4,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor, // set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
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
                        AppLanguageString.lOG_IN.tr.toUpperCase(),
                        style:
                            Get.textTheme.button!.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              AppSpaces.spaces_height_20,
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.SIGN_UP);
                  },
                  child: Text(
                    AppLanguageString.CREATE_ACCOUNT.tr,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              AppSpaces.spaces_height_25,
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: AppLanguageString.ACCEPT_TnC.tr,
                            style: TextStyle(color: AppColors.black)),
                        TextSpan(
                            text: AppLanguageString.TERMS_CONDITION.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                        TextSpan(text: ' ${AppLanguageString.AND.tr} '),
                        TextSpan(
                            text: AppLanguageString.PRIVACY_POLICY.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ))
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AppSpaces.spaces_height_25,
              SocialLoginButton(
                  image: AppAsset.google_icon,
                  text: AppLanguageString.GOOGLE_LOGIN.tr),
            ],
          ),
        ),
      ),
    );
  }
}
