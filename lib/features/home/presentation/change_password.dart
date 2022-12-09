import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/password_validator.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/common_widgets/customButtons.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  double boxHeight=Get.height * .45;
  PostData? postData;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  @override
  void initState() {
    postData = Provider.of<PostData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width*.0825),
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(0),
        height: boxHeight,
        width: Get.width,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.w,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      color: AppColors.textColor.withOpacity(.7),
                      fontSize: 17.sp,
                      fontFamily: 'Inter'
                  ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              PasswordInputField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Old password required';
                  }
                  else if(prefs!.getString('password') != oldPasswordController.text){
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return "Password doesn't match";
                  }
                },
                labelText: "Old password",
                height: Get.height * .035,
                textType: TextInputType.text,
                controller: oldPasswordController,
                borderRadius: 15,

              ),

              SizedBox(
                height: 10.w,
              ),
              PasswordInputField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Password is required';
                  }
                  if (!RegExp(r"(^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,32})")
                      .hasMatch(value))
                  {
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Min 8 characters with 1 uppercase,1 number';

                  }
                  if(!RegExp(r"(?=.*[@#$%!\-_?&])").hasMatch(value))
                  {
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Password must be contain 1 special character';
                  }
                  if(oldPasswordController.text==newPasswordController.text){
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'You have entered current password';
                  }
                },
                labelText: "New password",
                height: Get.height * .035,
                textType: TextInputType.text,
                controller: newPasswordController,
                borderRadius: 15,

              ),

              SizedBox(
                height: 10.w,
              ),
              PasswordInputField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Confirm Password is required';
                  }
                  if(newPasswordController.text !=
                      newPasswordController2.text){
                    setState(() {
                      boxHeight=boxHeight+boxHeight*.03;

                    });
                    return 'Passwords do not match';

                  }
                },
                labelText: "Confirm password",
                height: Get.height * .035,
                textType: TextInputType.text,
                controller: newPasswordController2,
                borderRadius: 15,

              ),

              SizedBox(
                height: 20.w,
              ),
              CustomButtons(
                width: Get.width * .75,
                height: Get.height * .06,
                borderRadius: 15,
                onTap: () async {
                  boxHeight=Get.height * .45;
                  var body = {
                    "old_password":oldPasswordController.text,
                    "new_password": newPasswordController.text,
                    "new_password2": newPasswordController2.text,
                  };

                  if (_formKey.currentState!.validate()) {
                    print("body"+body.toString());

                    postData!.changePassword(context, body,requestHeadersWithToken).whenComplete(() => Navigator.of(context).pop());
                    prefs!.setString('password', newPasswordController.text);
                  }
                  else{

                  }

                },
                text: "Reset Password",
                style: Get.textTheme.button!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
