import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/home/components/all_notification_list.dart';
import 'package:ketemaa/features/home/components/primary_notification_list.dart';

import 'package:ketemaa/core/models/NotificationListModel.dart';

class NotificationAlertBox extends StatefulWidget {
  final List<Results>? list;
  const NotificationAlertBox({Key? key,this.list}) : super(key: key);

  @override
  _NotificationAlertBoxState createState() => _NotificationAlertBoxState();
}

class _NotificationAlertBoxState extends State<NotificationAlertBox> {



  @override
  Widget build(BuildContext context) {
    return AlertDialog(

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
              style: TextStyle(fontSize: 22.0, color: AppColors.textColor),
            ),
            InkWell(
              onTap: () {
                Get.to(() => AllNotificationList(list: widget.list,));
              },
              child:  Text(
                  "See All",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),

            ),
          ],
        ),
        content:PrimaryNotificationList(list: widget.list,)
    );
  }
}
