import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class DetailsAppbar extends StatefulWidget {
  final String? name;
  const DetailsAppbar({Key? key,  this.name,}) : super(key: key);

  @override
  State<DetailsAppbar> createState() => _DetailsAppbarState();
}

class _DetailsAppbarState extends State<DetailsAppbar> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children:<Widget> [
        Container(
          padding: EdgeInsets.only(right: 75),
          height: 25,
          child:
          widget.name!.length < 30 ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
            child: Text(
              widget.name.toString(),
              style: TextStyle(
                  color: AppColors.textColor,
                  //fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ):
          Marquee(

            text: widget.name.toString(),
            style: TextStyle(
                color: AppColors.textColor,
                //fontFamily: 'Inter',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 200.0,
            velocity: 50.0,
            startPadding: 0.0,
            showFadingOnlyWhenScrolling: false,
            accelerationCurve: Curves.easeInBack,
          pauseAfterRound: Duration(seconds: 2),
          //  decelerationDuration: Duration(microseconds: 100),
           // decelerationCurve: Curves.easeOut,
           // numberOfRounds: 1,
          )
        ),
         Align(
          // alignment: Alignment.topLeft,
          alignment: const Alignment(.90, .20),
          child:InkWell(
            focusColor: Colors.transparent,
            onTap: () {
              /*showDialog(
                context: context,
                builder: (ctx) =>
                    ShowAlertBox(
                      results: data
                          .wishListModel!
                          .results![0],
                    ),
              );*/
            },
            child: Container(
              child: Icon(
                Icons.notifications_none,
                color: AppColors.textColor,
              ),
              height: 35.h,
              width: 35.h,
              decoration: BoxDecoration(
                gradient: AppColors.onBoardGradient,
                border: Border.all(
                    color: AppColors.grey, // set border color
                    width: 1), // set border width
                borderRadius: BorderRadius.circular(
                    12.0), // set rounded corner radius
              ),
            ),
          )
        ),
      ],
    );
  }
}
