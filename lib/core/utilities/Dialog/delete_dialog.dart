/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';


class DeleteDialog extends StatefulWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      title: Text(data.wishListModel!.results![index].productDetail!.name.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
      content: Text('Do you really want to delete this item?',style: TextStyle(color: Colors.white,fontSize: 15),),
      actions: <Widget>[

        CustomButtons(
          width: Get.width*.2,
          height: Get.height * .05,
          onTap: () {

            postData!.deleteWishlist(
              context,
              data.wishListModel!.results![index].id,
              requestHeadersWithToken,
            );
          },
          text: 'Yes'.toUpperCase(),
          style: Get.textTheme.button!.copyWith(color: Colors.white),
        ),
        CustomButtons(
          width: Get.width*.2,
          height: Get.height * .05,
          onTap: () {

            Navigator.pop(context);
          },
          text: 'Close'.toUpperCase(),
          style: Get.textTheme.button!.copyWith(color: Colors.white),
        ),
      ],
    );

  }
}
*/
