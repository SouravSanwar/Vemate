import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_loading.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import '_controller/sign_in_controller.dart';

class SignInWithEmail extends StatelessWidget {
  const SignInWithEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    //SigninController.to.signIn();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              _body(),
              _loading(),
            ],
          ),
        ),
      ),
    );
  }

  Column _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpaces.spaces_height_100,
        Text(
          AppLanguageString.LOGIN_IN_WITH.tr,
          style: Get.textTheme.headline4!.copyWith(color: Colors.black),
        ),
        AppSpaces.spaces_height_30,
        TextInputField(
          labelText: AppLanguageString.USERNAME.tr,
          height: .09,
          textType: TextInputType.emailAddress,
          controller: SigninController.to.emailTextFiledController,
        ),
        AppSpaces.spaces_height_5,
        PasswordInputField(
            labelText: AppLanguageString.PASSWORD.tr,
            height: .09,
            textType: TextInputType.text,
            controller: SigninController.to.passwordTextFiledController),
        AppSpaces.spaces_height_5,
        Container(
          margin: EdgeInsets.all(AppDimension.b1),
          height: Get.height * .09,
          width: Get.width * .5,
          decoration: BoxDecoration(
            color: AppColors.primaryColor, // set border width
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0)), // set rounded corner radius
          ),
          child: TextButton(
            onPressed: () {
              //Get.toNamed(AppRoutes.CONTROLLER_PAGE);

              SigninController.to.signIn(
                email: SigninController.to.emailTextFiledController.text
                    .toString(),
                password: SigninController.to.passwordTextFiledController.text
                    .toString(),
              );
            },
            child: Text(
              AppLanguageString.lOG_IN.tr.toUpperCase(),
              style: Get.textTheme.button!.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  _loading() {
    return Obx(() {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: SigninController.to.loading.value ? AppLoading() : Container(),
        ),
      );
    });
  }
}
