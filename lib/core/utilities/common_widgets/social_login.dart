import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/common_widgets/SocialLoginBorder.dart';

class SocialLogin extends StatelessWidget {
  final Widget _child;
  final VoidCallback _callback;

   const SocialLogin ({

     required Widget child,
     required VoidCallback onPressed,
   })  :
         this._child = child,
         this._callback = onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      strokeWidth:1,
      radius: 30,
      gradient: AppColors.onBoardBtnGradient,
      child: Container(
        width: Get.height * .067,
        height: Get.height * .067,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: _child,
      ),
      onPressed: _callback,
    );
  }
}