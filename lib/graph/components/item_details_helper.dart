import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utilities/app_colors/app_colors.dart';

class ItemDetailsHelper extends StatelessWidget{

  final String? text;
  final String? text1;
  ItemDetailsHelper ({
    this.text,
    this.text1,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: AppColors.cardGradient,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
                child: Text(
                  text!,style: TextStyle(
                    color: AppColors.detailsTextColor,
                    fontFamily: 'Inter',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold
                ),
                ),

                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12)

            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
                child: Text(
                  text1!,style: TextStyle(
                    color: AppColors.detailsTextColor1,
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold
                ),
                ),

                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2)

            ),
          ),
        ],
      ),
    );
  }

}