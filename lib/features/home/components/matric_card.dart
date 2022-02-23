import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';

class MatricesCard extends StatefulWidget {
  String? time;
  String? rate;

  MatricesCard({Key? key, this.time, this.rate}) : super(key: key);

  @override
  _MatricesCardState createState() => _MatricesCardState();
}

class _MatricesCardState extends State<MatricesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      width: Get.width * .3,
      //height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.time.toString(),
                style: Get.textTheme.bodyText2!.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w500)),
            AppSpaces.spaces_height_5,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/media/image/transfer.png',
                  height: 15.0,
                  width: 15.0,
                ),
                AppSpaces.spaces_width_5,
                Text(widget.rate.toString(),
                    style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
