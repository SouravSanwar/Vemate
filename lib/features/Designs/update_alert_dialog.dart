import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/functions/version_control.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateAlert extends StatefulWidget {
  const AppUpdateAlert({
    Key? key,
  }) : super(key: key);

  @override
  _AppUpdateAlertState createState() => _AppUpdateAlertState();
}

class _AppUpdateAlertState extends State<AppUpdateAlert> {
  double _height = 0, _width = 0;
  bool large = false;
  bool medium = false;

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  AppUpdate? fetchData;

  @override
  void initState() {
    fetchData = Provider.of<AppUpdate>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Consumer<AppUpdate>(builder: (context, data, child) {
      return Container(
        color: AppColors.backgroundColor,
        height: _height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.graphGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  width: _width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vemate Update",
                                  style: Get.textTheme.bodyText1!.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  "New Version ${data.appUpdator!.version!}",
                                  style: Get.textTheme.bodyText1!.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10.sp),
                                ),
                                AppSpaces.spaces_height_10,
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            height: 40.h,
                            width: 40.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/media/icon/logo1024.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      AppSpaces.spaces_height_10,
                      Text(
                        "What's New",
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: AppColors.textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            fontSize: 15.sp),
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        data.appUpdator!.description!,
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: AppColors.textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp),
                      ),
                      AppSpaces.spaces_height_5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          data.appUpdator!.isMajor == false
                              ? GestureDetector(
                                  onTap: () {
                                    fetchData!.updateApp();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Maybe Later",
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: AppColors.textColor,fontFamily: 'Inter',),
                                    ),
                                  ),
                                )
                              : Container(),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              gradient: AppColors.purpleGradient,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (Platform.isAndroid) {
                                  _launchURL(
                                      "market://details?id=${VersionControl.packageInfo.packageName}");
                                } else if (Platform.isIOS) {
                                  _launchURL(
                                      "https://apps.apple.com/gt/app/merchant-bay/id1590720968");
                                }
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(color: AppColors.white,fontFamily: 'Inter',),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
