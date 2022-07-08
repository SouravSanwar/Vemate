import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/home/notification/all_notification_list.dart';
import 'package:ketemaa/features/home/notification/primary_notification_list.dart';

import 'package:ketemaa/core/models/NotificationListModel.dart';

class NotificationAlertBox extends StatefulWidget {

  const NotificationAlertBox({Key? key}) : super(key: key);

  @override
  _NotificationAlertBoxState createState() => _NotificationAlertBoxState();
}

class _NotificationAlertBoxState extends State<NotificationAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        alignment: const Alignment(0, -0.75),
        backgroundColor: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.only(
          top: 10.0,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Notifications",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  color: AppColors.textColor),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const AllNotificationList());
              },
              child: Text(
                "See All",
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: const SizedBox(
          width: double.maxFinite,
          child: PrimaryNotificationList(),
        ));
  }
}
