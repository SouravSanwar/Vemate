import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/features/home/components/primary_notification_list.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertFrequencyDropdown.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTextfield.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertTypeDropDown.dart';
import 'package:ketemaa/features/vault/Wishlist/my_wishlist_page.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/WishListModel.dart';

class NotificationAlertBox extends StatefulWidget {

  const NotificationAlertBox({Key? key,}) : super(key: key);

  @override
  _NotificationAlertBoxState createState() => _NotificationAlertBoxState();
}

class _NotificationAlertBoxState extends State<NotificationAlertBox> {



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        alignment: Alignment(0.0, 0.0),
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
              "Price Alert",
              style: TextStyle(fontSize: 22.0, color: AppColors.textColor),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const WishListPage());
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
        content:PrimaryNotificationList()
    );
  }
}
