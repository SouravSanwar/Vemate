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
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: InkWell(
          onTap: onTap,
          splashColor: AppColors.backgroundColor,
          child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: const Color(0xff454F70)),
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
                  const Shader(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ],
              ))),
    );
  }
}
