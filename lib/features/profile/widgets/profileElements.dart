import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';


class CustomProfileElements extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback onTap;

  const CustomProfileElements(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
      child: InkWell(
          onTap: onTap,
          splashColor: AppColors.backgroundColor,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.graphCard,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.w,
                      ),
                      Shader(
                        icon: Icon(icon, color: Colors.white),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        text.toString(),
                        style:TextStyle(fontFamily: 'Inter',fontSize: 16.sp, color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textColor.withOpacity(.5),
                      size: 20,
                    ),
                  ),
                ],
              ))),
    );
  }
}
