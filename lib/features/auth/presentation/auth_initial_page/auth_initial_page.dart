import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/googleSignApi.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: Get.height * .05,
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
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      )),
                  AppSpaces.spaces_height_25,
                  TextInputField(
                    labelText: "Username/Email",
                    height: Get.height * .04,
                    textType: TextInputType.emailAddress,
                    controller: SigninController.to.userNameTextFiledController,
                  ),
                  SizedBox(
                    height: Get.height * .022,
                  ),
                  PasswordInputField(
                      labelText: "Password",
                      height: Get.height * .04,
                      textType: TextInputType.text,
                      controller:
                          SigninController.to.passwordTextFiledController),
                  SizedBox(
                    height: Get.height * .0124,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.RESET_PASS);
                    },
                    child: Container(
                        alignment: Alignment.bottomRight,
                        width: Get.width * .9,
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 12),
                        )),
                  ),
                  SizedBox(
                    height: Get.height * .022,
                  ),
                  CustomButtons(
                    width: Get.width * .9,
                    height: Get.height * .065,
                    onTap: () {
                      var body = {
                        "username": SigninController
                            .to.userNameTextFiledController.text,
                        "password": SigninController
                            .to.passwordTextFiledController.text,
                      };
                      //getConnection();
                      setState(() {
                        postData!.logIn(context, body);
                      });
                    },
                    text: AppLanguageString.lOG_IN.tr.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(color: Colors.white),
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
                    width: Get.height * .1,
                    height: Get.height * .067,
                    child: ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
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
                    width: Get.height * .1,
                    height: Get.height * .067,
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
                    width: Get.height * .1,
                    height: Get.height * .067,
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
              SizedBox(
                height: Get.height * .09,
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
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        AppSpaces.spaces_width_5,
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

  Future signIn() async {
    await GoogleSignInApi.login();
  }
}
