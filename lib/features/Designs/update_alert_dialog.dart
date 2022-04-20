import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/functions/version_control.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

bool? isUpdate;

class AppUpdateAlert extends StatefulWidget {
  const AppUpdateAlert({
    Key? key,
  }) : super(key: key);

  @override
  _AppUpdateAlertState createState() => _AppUpdateAlertState();
}

class _AppUpdateAlertState extends State<AppUpdateAlert> {
  double _height = 0, _width = 0;
  double _pixelRatio = 0;
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
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: _height,
      child: Center(
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(15),
                  width: _width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Update Version"),
                                Text(
                                    "New Version ${Platform.isIOS ? VersionControl.remoteConfig.getString("ios_version") : VersionControl.remoteConfig.getString("android_version")}"),
                                AppSpaces.spaces_height_10,
                                const Text('Update Info'),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/media/icon/logo1024.png"))),
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
                      AppSpaces.spaces_height_5,
                      Container(
                        alignment: Alignment.centerRight,
                        width: _width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: _width,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: VersionControl.remoteConfig
                                                    .getBool("major") ==
                                                false
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    fetchData!.updateApp();
                                                  },
                                                  child: const Text(
                                                      "May be Later"),
                                                ),
                                              )
                                            : Container()),
                                    Expanded(
                                      child: Padding(
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
                                                primary: Colors.green),
                                            child: const Text("Update")),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
