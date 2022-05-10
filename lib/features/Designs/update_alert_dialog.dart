import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/functions/version_control.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
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
    if (!await launch(url)) throw 'Could not launch $url';
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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Consumer<AppUpdate>(builder: (context, data, child) {
      return Container(
        color: Colors.black.withOpacity(0.5),
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
                      color: AppColors.lightBackgroundColor,
                      borderRadius: BorderRadius.circular(5)),
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
                                  style: Get.textTheme.bodyLarge,
                                ),
                                Text(
                                  "New Version ${data.appUpdator!.version!}",
                                  style: Get.textTheme.bodySmall,
                                ),
                                AppSpaces.spaces_height_10,
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            height: 40,
                            width: 40,
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
                        "What's New".toUpperCase(),
                        style: Get.textTheme.bodyLarge,
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        data.appUpdator!.description!,
                        style: Get.textTheme.bodySmall,
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
                                      "May be Later",
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (Platform.isAndroid) {
                                    _launchURL(
                                        "market://details?id=${VersionControl.packageInfo.packageName}");
                                  } else if (Platform.isIOS) {
                                    /*_launchURL(
                                      "https://apps.apple.com/gt/app/merchant-bay/id1590720968");*/
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      AppColors.primaryColor.withOpacity(.7),
                                ),
                                child: const Text("Update")),
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
