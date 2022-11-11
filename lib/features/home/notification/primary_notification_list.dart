import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/features/market/presentation/Details/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/Details/comic_details.dart';
import 'package:ketemaa/features/market/widgets/image_widgets.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class PrimaryNotificationList extends StatefulWidget {
  const PrimaryNotificationList({Key? key}) : super(key: key);

  @override
  State<PrimaryNotificationList> createState() =>
      _PrimaryNotificationListState();
}

class _PrimaryNotificationListState extends State<PrimaryNotificationList> {
  PostData? postData;
  GetData? getData;

  @override
  void initState() {
    postData = Provider.of<PostData>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: data.notificationListModel != null
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: data.notificationListModel!.results!.length > 4
                    ? 4
                    : data.notificationListModel!.results!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 8 : 4.0,
                            right: index == 9 ? 8 : 4.0),
                        child: InkWell(
                            onTap: () {
                              Map<String, String> requestHeadersWithToken = {
                                'Content-type': 'application/json',
                                'Accept': 'application/json',
                                'Authorization':
                                    'token ${prefs!.getString('token')}',
                              };

                              if (data.notificationListModel!.results![index]
                                      .target!.type ==
                                  0) {
                                postData!
                                    .notificationRead(
                                        context,
                                        data.notificationListModel!
                                            .results![index].target!.id,
                                        requestHeadersWithToken)
                                    .whenComplete(() => data
                                        .notificationListModel!
                                        .results![index]
                                        .unread = false);
                                Get.to(
                                  () => CollectibleDetails(
                                    productId: data.notificationListModel!
                                        .results![index].target!.id,
                                  ),
                                );
                                //Get.back();
                              } else {
                                postData!
                                    .notificationRead(
                                        context,
                                        data.notificationListModel!
                                            .results![index].target!.id,
                                        requestHeadersWithToken)
                                    .whenComplete(() => data
                                        .notificationListModel!
                                        .results![index]
                                        .unread = false);
                                Get.to(
                                  () => ComicDetails(
                                    productId: data.notificationListModel!
                                        .results![index].target!.id,
                                  ),
                                );
                                //Get.back();
                              }
                            },
                            child: Row(
                              children: [
                                ///dot icon
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: data.notificationListModel!
                                                  .results![index].unread ==
                                              true
                                          ? const Color(0xffA473E6)
                                          : AppColors.backgroundColor,
                                    ),
                                  ),
                                ),

                                ///Image
                                Container(
                                    height: 55.h,
                                    width: 55.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(.8),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.borderColor)),
                                    alignment: Alignment.center,
                                    child: data
                                                .notificationListModel!
                                                .results![index]
                                                .target!
                                                .image ==
                                            null
                                        ? FirstLetterImage(
                                            firstLetter: data
                                                .notificationListModel!
                                                .results![index]
                                                .description
                                                .toString()[0]
                                                .toUpperCase(),
                                            fontsize: 35,
                                          )
                                        : data
                                                    .notificationListModel!
                                                    .results![index]
                                                    .target!
                                                    .image!
                                                    .low_res_url ==
                                                null
                                            ? VeVeLowImage(
                                                imageUrl: data
                                                    .notificationListModel!
                                                    .results![index]
                                                    .target!
                                                    .image!
                                                    .image_on_list
                                                    .toString(),
                                              )
                                            : VeVeLowImage(
                                                imageUrl: data
                                                    .notificationListModel!
                                                    .results![index]
                                                    .target!
                                                    .image!
                                                    .low_res_url
                                                    .toString(),
                                              )),

                                SizedBox(
                                  width: Get.width * .02,
                                ),

                                ///details
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.notificationListModel!
                                            .results![index].description
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyText2!.copyWith(
                                                color: AppColors.textColor,
                                                //fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      Text(
                                        data.notificationListModel!
                                            .results![index].timesince
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
                                                color: AppColors.textColor
                                                    .withOpacity(.7),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      index != 3
                          ? const Divider()
                          : SizedBox(
                              height: 10.h,
                            )
                    ],
                  );
                },
              )
            : Container(),
      );
    });
  }
}

