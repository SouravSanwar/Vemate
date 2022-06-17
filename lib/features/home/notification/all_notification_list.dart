import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alertItems.dart';
import 'package:ketemaa/features/vault/Wishlist/alert/alert_box.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:ketemaa/core/models/NotificationListModel.dart';

class AllNotificationList extends StatefulWidget {
  final List<Results>? list;
  const AllNotificationList({Key? key,this.list}) : super(key: key);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title:Text(
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
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.list!.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(

                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                    child: Container(
                      width: Get.width,

                      child: InkWell(
                          onTap: () async {
                            var body = {};

                            Map<String, String> requestHeadersWithToken = {
                              'Content-type': 'application/json',
                              'Accept': 'application/json',
                              'Authorization':
                              'token ${prefs!.getString('token')}',
                            };

                            if (widget.list![index].target!.type == 0) {
                              postData!.notificationRead(
                                  context,
                                  widget.list![index].id,
                                  requestHeadersWithToken);
                              Get.to(() => CollectibleDetails(
                                productId: widget.list![index].target!.id,
                              ));
                            } else {
                              postData!.notificationRead(
                                  context,
                                  widget.list![index].id,
                                  requestHeadersWithToken);
                              Get.to(
                                    () => ComicDetails(
                                  productId: widget.list![index].target!.id,
                                ),
                              );
                            }
                          },
                          child: Container(
                            child: Row(
                              children: [
                                ///dot icon
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color:
                                      widget.list![index].unread == true
                                          ? Color(0xffA473E6)
                                          : AppColors.backgroundColor,
                                    ),
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.borderColor)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.list![index].target!.name
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
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
                                        widget.list![index].description
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      Text(
                                        widget.list![index].timesince
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
                                            color: AppColors.textColor
                                                .withOpacity(.7),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),


                ],
              );
            },
          )
        );
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

  //  getData!.getWishList();

    setState(() {
      refreshController.refreshCompleted();
      offset = 0;
    });
  }

  Future<void> _onLoading() async {
    offset = offset + 20;

    //getData!.getWishList(offset: offset);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}




