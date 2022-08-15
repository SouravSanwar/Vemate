import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
class BackPreviousScreen extends StatelessWidget{
  const BackPreviousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .045),
              alignment: Alignment.topLeft,
              child:InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white.withOpacity(.9),
                ),
              )
    );
  }

}