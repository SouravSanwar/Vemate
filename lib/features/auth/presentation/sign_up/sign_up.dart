import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import 'package:ketemaa/features/auth/presentation/sign_up/_controller/sign_up_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272E49),
      body: SingleChildScrollView(
        child: Center(
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
              Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: Get.width * .9,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  )),
              AppSpaces.spaces_height_25,
             /* Container(
                  width: Get.width * .9,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12),
                  )),*/

              TextInputField(
                labelText: "Username",
                height: .09,
                textType: TextInputType.text,
                controller: SignUpController.to.nameController,
              ),
              //AppSpaces.spaces_height_5,
              SizedBox(height: 15,),
              /*Container(
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
                labelText: "E-mail",
                height: .09,
                textType: TextInputType.emailAddress,
                controller: SignUpController.to.emailController,
              ),

              //AppSpaces.spaces_height_5,
              SizedBox(height: 15,),
              /*Container(
                  width: Get.width * .9,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12),
                  )),*/


              PasswordInputField(
                  labelText: "Password",
                  height: .09,
                  textType: TextInputType.text,
                  controller: SignUpController.to.passwordController),
              //AppSpaces.spaces_height_5,
             SizedBox(height: 15,),


              /* Container(
                  width: Get.width * .9,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12),
                  )),*/
              PasswordInputField(
                  labelText: "Confirm Password",
                  height: .09,
                  textType: TextInputType.text,
                  controller: SignUpController.to.confirmPasswordController),
              //AppSpaces.spaces_height_5,

              const SizedBox(
                height: 50,
              ),

              Container( margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 7),
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: AppColors.purpleGradient, // set border width
                  borderRadius: const BorderRadius.all(
                      Radius.circular(20.0)), // set rounded corner radius
                ),
                child: TextButton(
                  onPressed: () {
                    SignUpController.to.signUp();
                  },
                  child: Text(
                    AppLanguageString.SIGN_UP.tr.toUpperCase(),
                    style: Get.textTheme.button!.copyWith(color: Colors.white),
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
