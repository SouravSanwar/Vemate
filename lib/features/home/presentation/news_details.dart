import 'package:flutter/material.dart';
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
          color: AppColors.iconColor
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          news!.title.toString(),
          style: Get.textTheme.bodyLarge!.copyWith(color: AppColors.textColor,fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(Urls.mainUrl + news!.backgroundImage!.original!.src!),
            AppSpaces.spaces_height_10,
            Text(
              news!.text.toString(),
              textAlign: TextAlign.justify,
              style: Get.textTheme.bodyMedium!.copyWith(
                color: AppColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
