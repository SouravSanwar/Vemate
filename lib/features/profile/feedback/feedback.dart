import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/profile/feedback/feeback_body.dart';
import 'package:ketemaa/features/profile/feedback/greetingsPage.dart';
class FeedbackScreen extends StatefulWidget {

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: Get.height*.55,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                15.0,
              ),
            ),
            gradient:AppColors.onBoardGradient ),
        child: FeedbackBody.checkFeedback==1
            ? const FeedbackBody()
            : const GreetingsPage(),

      ),
      contentPadding: const EdgeInsets.all(0.0),
    );

  }
}
