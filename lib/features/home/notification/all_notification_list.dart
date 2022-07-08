import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:ketemaa/core/models/NotificationListModel.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({Key? key}) : super(key: key);

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList> {
  GetData? getData;
  PostData? postData;

  int offset = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refreshkey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    postData = Provider.of<PostData>(context, listen: false);

    getData = Provider.of<GetData>(context, listen: false);

    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.offAll(() => ControllerPage());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Notifications',
          style: Get.textTheme.headline2!.copyWith(color: AppColors.textColor),
        ),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return SmartRefresher(
            key: _refreshkey,
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(
              color: AppColors.primaryColor,
            ),
            footer: const ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: data.notificationListModel != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.notificationListModel!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Container(
                              width: Get.width,
                              child: InkWell(
                                  onTap: () async {
                                    var body = {};

                                    Map<String, String>
                                        requestHeadersWithToken = {
                                      'Content-type': 'application/json',
                                      'Accept': 'application/json',
                                      'Authorization':
                                          'token ${prefs!.getString('token')}',
                                    };

                                    if (data.notificationListModel!
                                            .results![index].target!.type ==
                                        0) {
                                      setState(() {
                                        postData!
                                            .notificationRead(
                                                context,
                                                data.notificationListModel!
                                                    .results![index].id,
                                                requestHeadersWithToken)
                                            .whenComplete(() => data
                                                .notificationListModel!
                                                .results![index]
                                                .unread = false);
                                      });
                                      Get.to(() => CollectibleDetails(
                                            productId: data
                                                .notificationListModel!
                                                .results![index]
                                                .target!
                                                .id,
                                          ));
                                    } else {
                                      setState(() {
                                        postData!
                                            .notificationRead(
                                                context,
                                                data.notificationListModel!
                                                    .results![index].id,
                                                requestHeadersWithToken)
                                            .whenComplete(() => data
                                                .notificationListModel!
                                                .results![index]
                                                .unread = false);
                                      });
                                      Get.to(
                                        () => ComicDetails(
                                          productId: data.notificationListModel!
                                              .results![index].target!.id,
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      ///dot icon
                                      Expanded(
                                        flex: 1,
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
                                      SizedBox(
                                        width: Get.width * .02,
                                      ),

                                      ///Image
                                      Container(
                                        height: 50.h,
                                        width: 50.h,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.borderColor)),
                                        alignment: Alignment.center,
                                        child: data.notificationListModel!
                                                    .results![index].image ==
                                                null
                                            ? Text(
                                                data.notificationListModel!
                                                    .results![index].description
                                                    .toString()[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: AppColors
                                                        .backgroundColor,
                                                    fontFamily: 'Inter',
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: data
                                                    .notificationListModel!
                                                    .results![index]
                                                    .image!
                                                    .image_on_list!
                                                    .src
                                                    .toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: _loader,
                                              ),
                                      ),
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : ColorLoader());
      }),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return const ImageIcon(
      AssetImage('assets/media/icon/logo v.png'),
      color: const Color(0xFF3A5A98),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    getData!.getNotification();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    getData!.getNotification(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
