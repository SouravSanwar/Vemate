import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class NotificationBadge extends StatefulWidget {
  const NotificationBadge({Key? key}) : super(key: key);

  @override
  State<NotificationBadge> createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      FlutterDynamicIcon.setApplicationIconBadgeNumber(10);
      return Container(
        child: data.notificationListModel!.totalUnread == 0
            ? Icon(
                Icons.notifications_none,
                color: AppColors.textColor,
              )
            : Badge(
                padding: const EdgeInsets.all(5),
                position: BadgePosition.topEnd(top: 3, end: 6),
                badgeContent: Text(
                  data.notificationListModel!.totalUnread! < 100
                      ? data.notificationListModel!.totalUnread.toString()
                      : "99+",
                  style: TextStyle(fontFamily: 'Inter', fontSize: 8.sp),
                ),
                badgeColor: Colors.redAccent,
                child: Icon(
                  Icons.notifications_none,
                  color: AppColors.textColor,
                ),
              ),
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(
              color: AppColors.grey, // set border color
              width: 1), // set border width
          borderRadius:
              BorderRadius.circular(15.0), // set rounded corner radius
        ),
      );
    });
  }
}
