import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ketemaa/core/models/NotificationListModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class NotificationBadge extends StatefulWidget {
  final NotificationListModel? notificationListModel;

  const NotificationBadge({Key? key, this.notificationListModel})
      : super(key: key);

  @override
  State<NotificationBadge> createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.notificationListModel!.totalUnread == 0
          ? Icon(
              Icons.notifications_none,
              color: AppColors.textColor,
            )
          : Badge(
              padding: const EdgeInsets.all(5),
              position: BadgePosition.topEnd(top: 3, end: 6),
              badgeContent: Text(
                widget.notificationListModel!.totalUnread! < 100
                    ? widget.notificationListModel!.totalUnread.toString()
                    : "99+",
                style: TextStyle(fontFamily: 'Inter',fontSize: 8.sp),
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
        borderRadius: BorderRadius.circular(15.0), // set rounded corner radius
      ),
    );
  }
}
