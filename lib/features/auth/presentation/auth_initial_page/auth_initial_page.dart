import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/image_slider.dart';
import 'package:ketemaa/core/utilities/common_widgets/social_login_button.dart';
import 'package:ketemaa/graph/designhelper.dart';
import 'package:provider/provider.dart';

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
  PostData? postData;

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());

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
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                  AppSpaces.spaces_height_25,
                  TextInputField(
                    labelText: "Email",
                    height: .09,
                    textType: TextInputType.emailAddress,
                    controller: SigninController.to.emailTextFiledController,
                  ),
                  AppSpaces.spaces_height_15,
                  PasswordInputField(
                      labelText: "Password",
                      height: .09,
                      textType: TextInputType.text,
                      controller:
                          SigninController.to.passwordTextFiledController),
                  AppSpaces.spaces_height_5,
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.RESET_PASS);
                    },
                    child: Container(
                        alignment: Alignment.bottomRight,
                        width: Get.width * .9,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
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
                        var body = {
                          "email":
                              SigninController.to.emailTextFiledController.text,
                          "password": SigninController
                              .to.passwordTextFiledController.text,
                        };
                        postData!.logIn(context, body);
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

              AppSpaces.spaces_height_25,
              Container(),
              AppSpaces.spaces_height_25,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 45.0, right: 10.0),
                        child: const Divider(
                          color: Colors.grey,
                        )),
                  ),
                  const Text(
                    "Or Continue With",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 45.0),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              AppSpaces.spaces_height_25,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset('assets/media/icon/google.png'),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/media/icon/apple.png',
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/media/icon/facebook.png',
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 70,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.SIGN_UP);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do You Have Any Account?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          "Register For Free",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ]),
                ),
              ),
              AppSpaces.spaces_height_15,
            ],
          ),
        ),
      ),
    );
  }
}
