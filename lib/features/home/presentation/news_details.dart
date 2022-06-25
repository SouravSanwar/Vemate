import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';

import '../../../core/models/NewsModel.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Results? news = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: AppColors.greyWhite
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          news!.title.toString(),
          style: Get.textTheme.bodyLarge!.copyWith(color: AppColors.textColor,fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.width *0.05167),
        child: ListView(
          children: [
            Image.network(Urls.mainUrl + news!.backgroundImage!.original!.src!),
            AppSpaces.spaces_height_10,
            Text(
              news!.text.toString(),
              textAlign: TextAlign.justify,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Inter',
                color: AppColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
