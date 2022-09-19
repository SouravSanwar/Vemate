import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/common_widgets/text_input_field.dart';
import 'package:ketemaa/features/BackPreviousScreen/back_previous_screen.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/password_validator.dart';
import 'package:ketemaa/features/auth/presentation/sign_up/_controller/sign_up_controller.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PostData? postData;
  bool? passDigitCheck = true;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    isValidPass=true;
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
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackPreviousScreen(),
                    SizedBox(
                      height: Get.height * .02,
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
                              "REGISTER",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: AppColors.textColor),
                            ),
                          ),
                          AppSpaces.spaces_height_25,
                          TextInputField(
                            validator:  (value) {
                                    if (value == null || value.trim().isEmpty) {
                                    return 'Username is required';
                                    }},
                            labelText: "Username",
                            height: Get.height * .04,
                            textType: TextInputType.text,
                            controller: SignUpController.to.nameController,
                          ),
                          SizedBox(
                            height: Get.height * .022,
                          ),
                          TextInputField(
                            labelText: "Email",
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
                            height: Get.height * .04,
                            textType: TextInputType.emailAddress,
                            controller: SignUpController.to.emailController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          PasswordInputField(
                            validator:  Validator.validator,
                            labelText: "Password",
                            height: Get.height * .04,
                            textType: TextInputType.text,
                            controller: SignUpController.to.passwordController,
                          ),
                          isValidPass==true? Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 35),
                            height: Get.height * .022,
                            child: Text(
                                    "*Min 8 characters with 1 uppercase,1 lowercase,1 number",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: AppColors.white.withOpacity(.7),
                                        fontSize: 11),
                                  )
                          ):Container(),
                          const SizedBox(
                            height: 8,
                          ),
                          PasswordInputField(
                            validator:  (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Confirm Password is required';
                              }
                              if(SignUpController.to.passwordController.text !=
                                  SignUpController
                                      .to.confirmPasswordController.text){
                                return 'Passwords do not match';

                              }
                              },
                            labelText: "Confirm Password",
                            height: Get.height * .04,
                            textType: TextInputType.text,
                            controller:
                                SignUpController.to.confirmPasswordController,
                          ),
                          SizedBox(
                            height: Get.height * .07,
                          ),
                          CustomButtons(
                            width: Get.width * .9,
                            height: Get.height * .065,
                            onTap: () async {


                              var body = {
                                "nickname":
                                    SignUpController.to.nameController.text,
                                "email": SignUpController.to.emailController.text,
                                "gender": "0",
                                "birth_year": "1852",
                                "fcm_device_id": "3",
                                "password":
                                    SignUpController.to.passwordController.text,
                                "user_creation": false
                              };

                              if (_formKey.currentState!.validate()) {

                                    postData!.signUp(context, body);
                              }
                              setState(() {
                                prefs!.setString('nickname', SignUpController.to.nameController.text);
                                prefs!.setString('email', SignUpController.to.emailController.text);
                                prefs!.setString('password', SignUpController.to.passwordController.text);
                                isValidPass=false;
                              });
                            },
                            text: AppLanguageString.SIGN_UP.tr.toUpperCase(),
                            style: Get.textTheme.button!.copyWith(
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
