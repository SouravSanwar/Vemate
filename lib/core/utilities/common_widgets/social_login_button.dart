import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class SocialLoginButton extends StatefulWidget {
  String image;
  String text;

  SocialLoginButton({required this.image, required this.text});

  @override
  _SocialLoginButtonState createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.hintColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            "LogIn Successful",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    /* fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.text == 'Continue with Email'
            ? Get.toNamed(AppRoutes.SIGN_IN_EMAIL)
            : _showToast();
        //print('Button Pressed: ${AppLanguageString.EMAIL_LOGIN}');
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: Get.height * .08,
        width: Get.width,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimension.b1),
              child: Image.asset(widget.image),
            ),
            Text(
              widget.text.tr,
              style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
